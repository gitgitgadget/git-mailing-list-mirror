From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCHv3 00/10] gitweb: Simple file based output caching
Date: Fri, 19 Feb 2010 01:14:15 +0100
Message-ID: <201002190114.21220.jnareb@gmail.com>
References: <1266349005-15393-1-git-send-email-jnareb@gmail.com> <4B7DB8A8.4020306@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 01:14:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiGVz-0003Pv-Is
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 01:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab0BSAOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2010 19:14:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:42408 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255Ab0BSAOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 19:14:31 -0500
Received: by fg-out-1718.google.com with SMTP id l26so43976fgb.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 16:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SBoDQEX8Rc6apF+iiA0uF0u+2K3t+pJZYy86pdI+oQA=;
        b=AOyq4L7SCSgNpV7WQDZiExpDbU8QUDmX9SjHalCrcWjJeAHzk4lva6w2cj2mcrMA+R
         HmkJVBR80iTD0wDEu95V0Bjop4RwU6+fT1s5XVNSwy1YeFHWT5n/j9TK6UW4aFVMjz6d
         laAvmh+izWaZ8FEGECLbt7Sg8fHnVZH40rCGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=goU5PTIEHMlmZLNKtNL35rNY6ITpV39bvuoveSUEGQ3UbRyVm6CcDYQcOjHI0CVVK0
         jzCD0PE/LQ0kf1HSE4donQpQHmrKc0YuBQw1+Hj4AzoNfeCzvLFHkeBinYob5Hg7ugWC
         WvHzBA5Ckg/c40HIxbyex0h44xogpbQsxh9BY=
Received: by 10.223.6.88 with SMTP id 24mr74340fay.2.1266538469879;
        Thu, 18 Feb 2010 16:14:29 -0800 (PST)
Received: from ?192.168.1.13? (abwu39.neoplus.adsl.tpnet.pl [83.8.244.39])
        by mx.google.com with ESMTPS id 28sm4527254fkx.52.2010.02.18.16.14.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 16:14:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B7DB8A8.4020306@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140397>

On Thu, 18 Feb 2010, J.H. wrote:

> > Shortlog:
> > ~~~~~~~~~
> > Jakub Narebski (10):

[removed all "Looks fine to me.]

> >   gitweb/cache.pm - Very simple file based cache
>
> This looks fine to me, and I'm much more keen on using the CHI interf=
ace.

=46irst, Cache::Cache is older and more mature than CHI, so it is more
likely for it to be installed (especially that nowadays CHI requires
Moose, modern OOP for Perl).

Second, I think that all caching engines (like Cache::Memcached and
Cache::FastMmap, which are not in Cache::Cache) provide ->get / ->set()
methods.  Not all provide ->compute() method, and those that provide
its equivalent might do it differently (Cache::Memcached uses callbacks=
),
or name method differently (Cache::FastMmap uses ->get_and_set() instea=
d
of ->compute()).

> >   gitweb/cache.pm - Stat-based cache expiration
>=20
> - I think having expires time at -1 (never) is a dangerous default.  =
I
> think having it as an option is fine, but setting this to something l=
ike
> 6 months may be a better option.  I wouldn't expect this to be an iss=
ue
> in reality, but I can just see someone screwing up and having a cache
> system that *never* expires.  I think I'd rather see something long v=
s.
> never.  But that's just my opinion.

You might be right here.  If it was generic cache engine, then default
to never expire is the only possible solution, as you don't know how
cache would be used, and what would be lifetimes involved.  But for
gitweb we can (try to) guess good default expire time.

Please do remember however that there are *two* sets of defaults.
=46irst is hardcoded in ->new() constructor for GitwebCache::SimpleFile=
Cache,
second is in %cache_options in gitweb, and this is the one that can be
changed in $GITWEB_CONFIG.  It is 'expires_on' value in %cache_options
that takes precedence (introduced in next commit), and it is 20 seconds=
=2E
=20
> - This does have the problem (though this gets fixed later on, again)
> that it would return invalid if there's a process already updating th=
e
> cache.  This might need to be fixed later to understand the locking
> structures on what is/isn't valid (this is mostly a note for me while=
 I
> read through the patches)

Yes, it is possible that more than one process would update cache. =20
Using locking is one of possible ways of solving or reducing this
issue, other is 'expires_variance' technique from CHI,... yet another
could be "touching" (setting mtime) of a cache file before regenerating
(refreshing it).

But GitwebCache::SimpleFileCache (err... the name could be better)
would always return correct (fully generated) cache entry, and would
not return partially filled data, even if there are more than one proce=
ss
generating data in parallel (simultaneously), thanks to "atomic write"
technique (write to temporary file, then rename said file to destinatio=
n).
=46ile::Temp (or UUID + sequence number) would ensure that processes do=
n't
stomp on each other data.
=20
> >   gitweb: Use Cache::Cache compatibile (get, set) output caching
>=20
> - It might be worth (in a later patch) enabling the PerlIO layers as
> there was a significant speed improvement in using them, despite thei=
r
> non-standardness.

As I wrote and said on #git, I think I was benchmarking incorrect thing=
;
what is important is the difference between writing large amount of dat=
a
(like e.g. snapshot) with different output capturing solutions; the
difference between PerlIO and other solutions was the difference betwee=
n
12 =CE=BCs (microseconds) and 18 =CE=BCs _when profiling_, or something=
 like that.


NOTE: output caching for gitweb consists of three separate issues:
* caching engine (GitwebCache::SimpleFileCache, or other caching engine
  supporting ->get/->set or ->compute (see also below))
* capturing output (current 'select(FILEHANDLE)' solution, possible
  tie filehandle and PerlIO layers solutions, or "tee" solutions...
  but that could be added later)
* output caching driver (a la CGI::Cache, or Plack::Middleware::Cache,
  which gets data from cache and prints it, or captures and prints
  or "tee"s output and saves it to cache).

We can provide other options for capturing output, but this should be
IMVHO left for later commits, isn't it?

>=20
> - What if you want to use a different caching library but don't want
> cache.pm ?  That first bit of "if ($caching_enabled) {" might need to=
 be
> wrapped to figure out if we are using our inbuilt caching or an exter=
nal
> caching system. (just thinking out loud)

It is described in gitweb/README... although I haven't tested it myself
(probably should have at least for one other engine, like=20
Cache::FileCache).

In short you can set $cache variable to instance (initialized object)
of selected caching engine, perhaps using %cache_options in its=20
constructor, or set $cache to string containing name of cache class,
and add extra options to constructor in %cache_options.
=20
> Looks fine to me.
>=20
> >   gitweb/cache.pm - Adaptive cache expiration time
>=20
> is the commented:
>=20
> #return &{$self->{'check_load'}}();
>=20
> intended in check_load() ?
>=20
> otherwise this looks fine to me.

Leftover from thinking about different ways of writing it.  You can
write either &{$self->{'check_load'}}(), or you can write
$self->{'check_load'}->() - it is a matter of style.

Sidenote: we should probably standarise whether caller or the method
itself is responsible for checking if field is set, in the like methods
(there would be one more like that: the 'generating_info' callback).

>=20
> >   gitweb: Use CHI compatibile (compute method) caching
>=20
> Looks fine to me.  I think it's fine where it's at in the order mysel=
f.

O.K.

> >   gitweb: Show appropriate "Generating..." page when regenerating c=
ache
>=20
> I've got a couple of things that will need to be added on top of this
> (mainly to try and guess if the client is dumb or smart) so that if i=
t
> won't support "Generating..." as expected it doesn't get it.  But tha=
t can
> come in a later patch.

See subthread http://thread.gmane.org/gmane.comp.version-control.git/13=
6913/focus=3D137805
in first version of [split] output caching for gitweb series.

--=20
Jakub Narebski
Poland
