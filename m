Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0210220756
	for <e@80x24.org>; Tue, 10 Jan 2017 14:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941224AbdAJONx (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 09:13:53 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:48062 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938660AbdAJOMg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 09:12:36 -0500
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v0AECW4K005896
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2017 14:12:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v0AECWdi004308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2017 14:12:32 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v0AECUwr021279;
        Tue, 10 Jan 2017 14:12:31 GMT
Received: from localhost (/10.175.232.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Jan 2017 06:12:30 -0800
Date:   Tue, 10 Jan 2017 15:17:31 +0100
From:   Quentin Casasnovas <quentin.casasnovas@oracle.com>
To:     Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Refreshing index timestamps without reading content
Message-ID: <20170110141731.GH7000@chrystal.oracle.com>
References: <20170105112359.GN8116@chrystal.oracle.com>
 <CACsJy8BRfJG6L49VyC+qsrQ9Arz0gCGpMATpK9uLq61Lx6_Jtg@mail.gmail.com>
 <xmqqr34cuvjj.fsf@gitster.mtv.corp.google.com>
 <20170109155537.GG7000@chrystal.oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q59ABw34pTSIagmi"
Content-Disposition: inline
In-Reply-To: <20170109155537.GG7000@chrystal.oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Q59ABw34pTSIagmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 04:55:37PM +0100, Quentin Casasnovas wrote:
> On Mon, Jan 09, 2017 at 07:01:36AM -0800, Junio C Hamano wrote:
> > Duy Nguyen <pclouds@gmail.com> writes:
> >
> > > On Thu, Jan 5, 2017 at 6:23 PM, Quentin Casasnovas
> > > <quentin.casasnovas@oracle.com> wrote:
> > >> Is there any way to tell git, after the git ls-tree command above, to
> > >> refresh its stat cache information and trust us that the file conten=
t has
> > >> not changed, as to avoid any useless file read (though it will obvio=
usly
> > >> will have to stat all of them, but that's not something we can really
> > >> avoid)
> > >
> > > I don't think there's any way to do that, unfortunately.
> >
> > Lose "unfortunately".
> >
> > >> If not, I am willing to implement a --assume-content-unchanged to th=
e git
> > >> update-index if you guys don't see something fundamentally wrong wit=
h this
> > >> approach.
> > >
> > > If you do that, I think you should go with either of the following op=
tions
> > >
> > > - Extend git-update-index --index-info to take stat info as well (or
> > > maybe make a new option instead). Then you can feed stat info directly
> > > to git without a use-case-specific "assume-content-unchanged".
> > >
> > > - Add "git update-index --touch" that does what "touch" does. In this
> > > case, it blindly updates stat info to latest. But like touch, we can
> > > also specify  mtime from command line if we need to. It's a bit less
> > > generic than the above option, but easier to use.
> >
> > Even if we assume that it is a good idea to let people muck with the
> > index like this, either of the above would be a usable addition,
> > because the cached stat information does not consist solely of
> > mtime.
> >
> > "git update-index --index-info" was invented for the case where a
> > user or a script _knows_ the object ID of the blob that _would_
> > result if a contents of a file on the filesystem were run through
> > hash-object.  So from the interface's point of view, it may make
> > sense to teach it to take an extra/optional argument that is the
> > path to the file and take the stat info out of the named file when
> > the extra/optional argument was given.
> >
> > But that assumes that it is a good idea to do this in the first
> > place.  It was deliberate design decision that setting the cached
> > stat info for the entry was protected behind actual content
> > comparison, and removing that protection will open the index to
> > abuse.
> >
>=20
> Hi Junio,
>=20
> Thanks for your feedback, appreciated :)
>=20
> I do understand how it would be possible for someone to shoot themselves =
in
> the feet with such option, but it solves real life use cases and improved
> build times very signficantly here.
>=20
> Another use case we have is setting up very lightweight linux work trees,
> by reflinking from a base work-tree.  This allows for a completely
> different work-tree taking up almost no size at first, whereas using a
> shared clone or the recent worktree subcommand would "waste" ~500MB*:
>=20
>  # linux-2.6 is a shared clone of a bare clone residing locally
>  ~ $ cp --reflink -a linux-2.6 linux-2.6-reflinked
>=20
>  # At this point, the mtime inside linux-2.6-reflinked are matching the
>  # mtime of the source linux-2.6 (since we used the '-a' option of 'cp)
>  ~ $ diff -u <(stat linux-2.6/README) <(stat linux-2.6-reflinked/README)
>  --- /proc/self/fd/11  2017-01-09 16:34:04.523438942 +0100
>  +++ /proc/self/fd/12  2017-01-09 16:34:04.523438942 +0100
>  @@ -1,8 +1,8 @@
>  -  File: 'linux-2.6/README'
>  +  File: 'linux-2.6-reflinked/README'
>     Size: 18372		Blocks: 40         IO Block: 4096   regular file
>  -Device: fd00h/64768d	Inode: 268467090   Links: 1
>  +Device: fd00h/64768d	Inode: 805970606   Links: 1
>   Access: (0644/-rw-r--r--)  Uid: ( 1000/ quentin)   Gid: ( 1000/ quentin)
>   Access: 2017-01-09 12:04:15.317758718 +0100
>   Modify: 2017-01-09 12:04:12.566758772 +0100
>  -Change: 2017-01-09 12:04:12.566758772 +0100
>  +Change: 2017-01-09 16:29:48.305444003 +0100
>    Birth:
>=20
>   # Now let's check how long it takes to refresh the index from the source
>   # and destination..
>   ~/linux-2.6 $ time git update-index --refresh
>   git update-index --refresh  0.04s user 0.08s system 204% cpu 0.058 total
>                                                                ~~~~~~~~~~~
>   ~/linux-2.6-reflinked $ time git update-index --refresh
>   git update-index --refresh  2.40s user 1.43s system 38% cpu 10.003 total
>                                                               ~~~~~~~~~~~~
>=20

After discussing this with my friend Vegard, he found the core.checkStat
config which, if set to 'minimal', ignores the inode number which is enough
for the above use case to work just fine - so please excuse my ignorance!

For the initial problem I had when changing the mtime of all the files in
the tree, I should be able to change the mtime of the object files instead,
hence I don't really need the patch I sent earlier.

Sorry for the wasted time! :)

Q

--Q59ABw34pTSIagmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYdOz1AAoJEB5Tt01po9cNrKAP/RoKlZRQPLdRFX6zKoBUN1UJ
+E41w3Xdh0aRP2wg5GlZZUHSeU2VTs28yY49xlNEddMV/ItQyJyRxOFQ43HrLwbp
Ewrm/cVM5KyBPcEb8HUt3mjX50EiPr9INJ5ZcBn7ko3hIkFh+/PPHRqmpCRq0T94
LnXv0V4018iZ/X9HoAFdZ6cn/ddD49KTgn55lLpYxJnM6xByADFuzI1hmjX7tPi9
Tq/dIXBghD/jeSw1MsOvOfikily1X4xgdWcQa0fmmwxHsTP1Tp2yDdQVgFy7/yuH
c3Fbqq3J52M4xV+hG6alxF47oItZ6huOnTLryLpUKHXhnk+2zo6vNX/AeGYdHDz1
FeQp7fTSqmge9oU2a1siA2nf6+4Q11TXD+LQUDKircBQF2IzZGFFi4OqcznrHaeB
J0wDNQ3ipDxObTA98Jnea2TYMb9dJpJc5S4ViUKosFHxfEttHPL7r/ohgGGZn05e
QKQPaSzyJFY5uzbzozc6jOiPrLIHmQEBgRd/HRc2H6ALqvTqvYrM6wLMr3nE3yDG
lQ8W/7cFO16+/BuCakT3JP3ikSwD31wLaBd0xZODdClNDwWnrG5H01UCiig/fnc2
Wrlj1LwhCyN0jxpjKmgW+hykiBcaXOxY83iO5jyKGI4WxX0mXsGDjAcZsR9He2vV
wezHqvd0ImuMhV5BJ6Up
=vXxs
-----END PGP SIGNATURE-----

--Q59ABw34pTSIagmi--
