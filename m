From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 2/2] refs.c: SSE4.2 optimizations for
 check_refname_component
Date: Thu, 05 Jun 2014 15:26:02 -0400
Organization: Twitter
Message-ID: <1401996362.18134.179.camel@stross>
References: <1401853091-15535-1-git-send-email-dturner@twitter.com>
		 <1401853091-15535-2-git-send-email-dturner@twitter.com>
		 <538ED2F1.9030003@web.de>
		 <CACsJy8CK3LNaPVNv=EfFX06uOgpujAz364ZDFL3HBPicDNF57w@mail.gmail.com>
		 <538F2C6B.2030004@web.de> <1401916560.18134.167.camel@stross>
	 <539062D9.60000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twitter.com>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 21:39:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsdIh-0005XO-Vt
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 21:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbaFET0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jun 2014 15:26:07 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:37139 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbaFET0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 15:26:06 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so2421164qgd.1
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 12:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=gHV2jhdBw2F8+bXXFYH5NmnYSRu7TVuWMoKSF38nMeg=;
        b=iKn2uCp1ZxnHuySmQKaJv7l2UwEHsn1Na4qCxVWKcR58kvFmO4sm1uRobL17OUze4n
         R5EH80yfYwMqYm/Ug1WDI7/0hHwgLL678WL3IsdQb9RL+GNuq5HAdvPpt08jWRVVlSKT
         OJj9lOA9i2ICqv8KjeD97QpO/wjaMMUH6VErVb/j3yAyFmZ0Y3u+5VBauwDDFx2gN77H
         NxvqAbpYaBSmjtAQFXf8ztooAddFwPO7VmOaXDcpzQoqxYHbv0cMbra/OJKbbqV0VryM
         akXiTn4MB4wPsNwvUkR3RuETCVlzV1VuHV7TiUH7iTeB9qs8H1/wG99S1Ccl4QPKRSlp
         QjHA==
X-Gm-Message-State: ALoCoQkaFzEaBfKwKnHlQe06F1O+aXjIf9gKIVL6Gygy5q1XdtoazVeds+6w5iFbWxlydl7QLKJE
X-Received: by 10.140.86.99 with SMTP id o90mr81088786qgd.14.1401996364914;
        Thu, 05 Jun 2014 12:26:04 -0700 (PDT)
Received: from [172.17.3.196] ([38.104.173.198])
        by mx.google.com with ESMTPSA id j3sm4294502qgj.24.2014.06.05.12.26.03
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 05 Jun 2014 12:26:03 -0700 (PDT)
In-Reply-To: <539062D9.60000@web.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250860>

On Thu, 2014-06-05 at 14:30 +0200, Torsten B=C3=B6gershausen wrote:
> On 2014-06-04 23.16, David Turner wrote:
> >=20
> > Sure!  I actually went with > 120k to make measurement easier:
> > https://github.com/dturner-tw/many-refs
> Hm, I didn't get so man
>=20
> git remote -v
> origin  https://github.com/dturner-tw/many-refs=20
>=20
>  wc .git/packed-refs=20
>      750    1130   38868 .git/packed-refs
>=20

Oops.  It looks like I forgot to push all of the refs.  And when I try,
it fails with "fatal: cannot exec 'send-pack': Argument list too long"

I hacked git to send batches of 1000; maybe I'll actually make a real
patch with ARG_MAX at some point. Anyway, this is uploading now, but I
estimate that it will take at least five hours, because github is being
really slow about this.

=2E..
> where only patch 1/2 doesn't seem to speed up things on my system:
=2E..

I would not expect a noticeable change on a tiny number of refs; it's
only when ref parsing takes up a large percentage of runtime -- tens of
thousands of refs.
