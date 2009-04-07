From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 7 Apr 2009 15:37:03 +0200
Message-ID: <200904071537.04225.jnareb@gmail.com>
References: <20090404220743.GA869@curie-int> <m3tz5023rq.fsf@localhost.localdomain> <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-2?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>, david@lang.hm,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 15:35:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrBSw-0002oI-1f
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 15:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbZDGNeR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 09:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZDGNeQ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 09:34:16 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:40137 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZDGNeP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 09:34:15 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2765064wff.4
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=s8TNLMOfFrO+Ip8tPn/q0tKJXFnH18HXoDtFaBhHdAA=;
        b=hQu0gIAjsyy0/xmaUmTEkkzXnX/Xr5wcf4cqMS4xZHXK/3G1DyTYJRxw3L7yZXTiFh
         4MENPn3FrUg1FBbVYyO2r1OwYtyTY6i3JLGhp2PqgtJBbbRXzmMNkpDSHA4uyPrNlPYC
         CbYldYrIAq6YepI9KK19LGW031TM7ijaFpEJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ofo3V9VBlq42kZY+jU1ftNe55s3Kwr4pSQnsSMIR8Gre/rN3oG8tQULt8yVO8uUJUv
         Ll6jWk8brzeMcwB/ixtRae0ikrowdLlHFKUNhQIciOoc/UVdpDLpzseU0uD+pSP5th2q
         IXzdd71xYcuibMt0LUNFL6YMG2XkRkEF4Eo9o=
Received: by 10.142.172.12 with SMTP id u12mr38853wfe.132.1239111255105;
        Tue, 07 Apr 2009 06:34:15 -0700 (PDT)
Received: from ?192.168.1.13? (abuz219.neoplus.adsl.tpnet.pl [83.8.197.219])
        by mx.google.com with ESMTPS id 24sm6646144wff.22.2009.04.07.06.34.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 06:34:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115955>

On Tue, 7 Apr 2009, Nicolas Pitre wrote:
> On Tue, 7 Apr 2009, Jakub Narebski wrote:
>> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:

[...]
>>> It's not primarily pack-objects, I think. It's the rev-list that's =
run
>>> by upload-pack.  Running "git rev-list --objects --all" on that rep=
o
>>> eats about 2G RSS, easily killing the system's cache on a small box=
,
>>> leading to swapping and a painful time reading the packfile content=
s
>>> afterwards to send them to the client.
>>=20
>> Than I think that "packfile caching" GSoC project (which is IIRC
>> "object enumeration caching", or at least includes it) should help
>> here.
>=20
> NO!
>=20
> Please people stop being so creative with all sort of ways to simply=20
> avoid the real issue and focussing on a real fix.  Git has not become=
=20
> what it is today by the accumulation of workarounds and ignorance of=20
> fundamental issues.
>=20
> Having git-rev-list consume about 2G RSS for the enumeration of 4M=20
> objects is simply inacceptable, period.  This is the equivalent of 50=
0=20
> bytes per object pinned in memory on average, just for listing object=
,=20
> which is completely silly. We ought to do better than that.

I have thought that the large amount of memory consumed by git-rev-list
was caused by not-so-sequential access to very large packfile (1.5GB+ i=
f
I remember correctly), which I thought causes the whole packfile to be
mmapped and not only window, plus large amount of objects in 300MB+ mem
range or something; those both would account for around 2GB.

Besides even if git-rev-list wouldn't take so much memory, object
enumeration caching would still help with CPU load... admittedly less.

--=20
Jakub Narebski
Poland
