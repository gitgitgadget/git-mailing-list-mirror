From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: purging unwanted history
Date: Mon, 17 Nov 2008 13:33:07 +1030
Message-ID: <93c3eada0811161903v7b6c7abaq58cb6712190d03d5@mail.gmail.com>
References: <93c3eada0811161626h69929cd7va3fa4007a2341bae@mail.gmail.com>
	 <20081117022412.GB3911@atjola.homenet>
	 <20081117022714.GC3911@atjola.homenet>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 17 04:04:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1uPg-0003Zr-WB
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 04:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbYKQDDM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Nov 2008 22:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754776AbYKQDDL
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 22:03:11 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:46536 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbYKQDDJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Nov 2008 22:03:09 -0500
Received: by gxk4 with SMTP id 4so1375876gxk.13
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 19:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=t4QP0ptcjdgeZcp5H3C8eN7ZTw7GzbRtSqKsIfxqOBk=;
        b=rzulG/5OZ269TE/teVDN6XS8y1wykpexj1gPdx1HAStaRMf1BMjyi9JT07Z/XJtkFi
         zrzhrtoDyWg7E8DEAaBk+Pt4oA6+z/CBhfqbRbREpSl2/XdSzs1cztSGbRxN/Dpuj6HL
         TlQWJ/zzBufWJnN+Bdf1XxJNA///ZrM+S40b8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=xH1JUPx+1rtovkWzb15K2wAlWnxqiaA59DgyXGnpJarwovqxSj8lHhT6BtNEzMFqfB
         oz7eSUBGEjn8pW/ZZa51gxTTLJA3J1GvRD/sdV7QlYeVroTrdeI5aIS97hwFeN3Gd4Xi
         8wtwpwTYw7QQ77TnZm2tlf+WGUts24Tpm75ho=
Received: by 10.151.6.16 with SMTP id j16mr7029237ybi.67.1226890987293;
        Sun, 16 Nov 2008 19:03:07 -0800 (PST)
Received: by 10.150.121.2 with HTTP; Sun, 16 Nov 2008 19:03:07 -0800 (PST)
In-Reply-To: <20081117022714.GC3911@atjola.homenet>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101194>

On Mon, Nov 17, 2008 at 12:57 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.=
de> wrote:
> On 2008.11.17 03:24:12 +0100, Bj=F6rn Steinbrink wrote:
>> On 2008.11.17 10:56:23 +1030, Geoff Russell wrote:
>> > I have a repository with 5 years worth of history, I only want to =
keep
>> > 1 year, so I want to purge the first 4 years. As it happens, the
>> > repository only has a single branch which should simplify the prob=
lem.
>>
>> Use filter-branch to drop the parents on the first commit you want t=
o
>> keep, and then drop the old cruft.
>>
>> Let's say $drop is the hash of the latest commit you want to drop. T=
o
>> keep things sane and simple, make sure the first commit you want to
>> keep, ie. the child of $drop, is not a merge commit. Then you can us=
e:
>>
>> git filter-branch --parent-filter "sed -e 's/-p $drop//'" \
>>       --tag-name-filter cat -- \
>>       --all ^$drop
>>
>> The above rewrites the parents of all commits that come "after" $dro=
p.
>>
>> Check the results with gitk.
>>
>>
>> Then, to clean out all the old cruft.
>>
>> First, the backup references from filter-branch:
>>
>> git for-each-ref --format=3D'%(refname)' refs/original | \
>>       while read ref
>>       do
>>               git update-ref -d "$ref"
>>       done
>>
>> Then clean your reflogs:
>> git reflog expire --expire=3D0 --all
>>
>> And finally, repack and drop all the old unreachable objects:
>> git repack -ad
>> git prune # For objects that repack -ad might have left around
>>
>> At that point, everything leading up to and including $drop should b=
e
>> gone.
>
> Hm, on second thought, if you have tags referencing some of the old
> history, they'll still be around, I think. Just delete those before y=
ou
> start the rewriting.
>
> And of course do the above with a copy of your repo. Just in case.
>
> Bj=F6rn
>

Great, I've just tested this and it is exactly what I want. I'm still
getting my head around
why, but understanding will arrive with a little more thought.


Many thanks,

Geoff



--=20
6 Fifth Ave,
St Morris, S.A. 5068
Australia
Ph: 041 8805 184 / 08 8332 5069
