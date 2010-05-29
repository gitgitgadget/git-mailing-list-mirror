From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [PATCH 3/7] Add buffer pool library
Date: Sat, 29 May 2010 20:55:24 +1000
Message-ID: <512B4EA0-463F-4CF2-94AB-404BF1BAE229@cordelta.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com> <1274650832-7411-4-git-send-email-artagnon@gmail.com> <20100529085124.GA6847@progeny.tock>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 12:55:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIJhk-0007SA-As
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 12:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab0E2Kza convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 06:55:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:55914 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663Ab0E2Kz3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 May 2010 06:55:29 -0400
Received: by pxi18 with SMTP id 18so888690pxi.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=Dy5ZvR0B6VdhpOjpVTonwGCUUwXIBRbWCXXyoHHXSgI=;
        b=CvA1MOR1A2Aql6d2ysFszIC/KAGfcoj+2n0+BydkDiFfx5S5MNlOGMyV5vT4P8d2q/
         7UsTFu+Ruy4WThp1yq2kmuiPCxpfpuGHHH0IiqGRvB/XHTnI1TafYhLv896P2DN59qvN
         9ptKsyKwIuClj4c3ttUzj+QqriqmrhOcOCWP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=TFqdfFLEZeOKJ+ET/NzK/POaQbf8eq+VZZ+i/JtFo2XkzKtE3aVQYnd6KxVbCglmAk
         XfjDrz55DDPCw/VJpG9hiiu6sjeI4tq1jjYpW9O1PiPuPgSV5z/ZLBL3EhvxXlhrQlVe
         0ZbbO1a+MkpZNRI1SOezFX0/97FK9ya1zFt3c=
Received: by 10.114.4.37 with SMTP id 37mr1328627wad.120.1275130529100;
        Sat, 29 May 2010 03:55:29 -0700 (PDT)
Received: from [192.168.1.2] (d122-109-106-179.mit3.act.optusnet.com.au [122.109.106.179])
        by mx.google.com with ESMTPS id c1sm28359578wam.19.2010.05.29.03.55.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 03:55:28 -0700 (PDT)
In-Reply-To: <20100529085124.GA6847@progeny.tock>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147962>

Ji Jonathan,

>> line_buffer creates a couple of static buffers and expose an API for
>> using them.
>=20
> So this provides a thread-unsafe fgets() and fread() where the caller
> does not have to supply a buffer.  Sounds convenient.

Very convenient indeed. Its primary reason for existence is to assist
debugging the svn dump parser.

> Missing From: line and sign-off.

I'm sure Ram will fix this up in the next rebase.

>> +char *buffer_read_line(void)
>> +{
>> +    char *end;
>=20
> style nitpick: use tabs to indent.

Will read git style guide and try to match for convenience.

> Why not fgets()?

Historical reasons, can be factored out.

> So if this buffer library is in use, all input needs to pass through
> it?  I would prefer to avoid that if possible.

The design is almost single-caller anyway...

>> +        line_len +=3D offset;
>> +    }
>> +    while (offset < len && !feof(stdin)) {
>> +        offset +=3D fread(&s[offset], 1, len - offset, stdin);
>> +    }
>=20
> On error, wouldn=92t this be an infinite loop?  Maybe:
>=20
>  offset +=3D fread(&s[offset], 1, len - offset, stdin);
>  if (ferror(stdin)) {
> 	free(s);
> 	return NULL;
> }
>=20
> One iteration should be sufficient, since fread loops internally

Thanks for the tip.

--
David Barr
