From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v8 2/2] format-patch --signature-file <file>
Date: Thu, 22 May 2014 22:55:17 -0700
Message-ID: <20140523055517.GA30019@hudson.localdomain>
References: <1400723589-8975-1-git-send-email-jmmahler@gmail.com>
 <1400723589-8975-3-git-send-email-jmmahler@gmail.com>
 <xmqqtx8hmt7m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 07:55:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WniS3-0005gW-28
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 07:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbaEWFzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 01:55:24 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36787 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbaEWFzX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 01:55:23 -0400
Received: by mail-pa0-f52.google.com with SMTP id fa1so3625091pad.39
        for <git@vger.kernel.org>; Thu, 22 May 2014 22:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=cCrR7PREv/aVi6gBVx7P4LXRJNAbKTbTwApse0C3MPs=;
        b=OBmYUPkb3YVMDSLXUlanDw5urZ52F2rYTfhOPohDRTqTGlrqS004tYovRMb4cWKxX/
         oEB3jY8RMYiD5K+g3sLD4td0uX/82MoeQMw32cfJsM1sTHUfba1AOGFLZNMXH79jlW4o
         FHrDDosw1mqA5nUALrZ5zgFJEDF21whujDi10Xqh0Fw7BakpdNfLc4pUHkoP4TrzZWwH
         DXuKE2tFC4U36E3twaSnSh2oL3KlFsVrO0of/csbwNqZdWEFyS8Lr/AGFNDAMDSpDzrs
         Icflk6TGyPhUBsVyJXyasg8w8EXco159POUjI9dZapOESWNqNea48ki/C8uxYaZquIfZ
         KL6g==
X-Received: by 10.68.110.129 with SMTP id ia1mr3031281pbb.158.1400824523031;
        Thu, 22 May 2014 22:55:23 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id rx10sm9086413pab.48.2014.05.22.22.55.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 22:55:20 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Thu, 22 May 2014 22:55:17 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqtx8hmt7m.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249975>

Junio,

On Thu, May 22, 2014 at 01:52:45PM -0700, Junio C Hamano wrote:
> Jeremiah Mahler <jmmahler@gmail.com> writes:
> 
...
>
> Something like:
> 
>     To countermand the configuration variable for a specific run:
> 
> 	$ git format-patch -1 --signature="This time only"
>         $ git format-patch -1 --signature    ;# to use the default
>         $ git format-patch -1 --signature="" ;# to add nothing
> 
...
>
> I didn't see offhand if the tests make sure that a configured mail
> signature can be overriden from the command line.  I think you would
> want to test, with format-patch.signature-file pointing at the
> mail-signature file, at least these three cases:
> 
>  - Run "format-patch --no-signature" and make sure that stops the
>    contents from mail-signature file from being shown, and instead
>    no mail-signature is given.
> 
--no-signature should inhibit all signatures.

>  - Run "format-patch --signature='this time only'" and make sure
>    that stops the contents from mail-signature file from being shown
>    and "this time only" is used instead.
> 
>  - Run "format-patch --signature-file=another-mail-signature" and
>    make sure that stops the contents from mail-signature file from
>    being shown and the contents from the other file is used instead.
> 
Arguments on the command line should take precendence over
anything in the config.

Your comments make it clear that I have not accounted for all the possible
cases.  Below is a table of all the reasonable cases.  It should account
for cases you mentioned as well as others.

  Key:
  ---
  default: Git version number
  sig1: .signature from column 1
  file1: .signaturefile from column 1
  sig2: --signature from column 2
  file2: --signature-file in column 2

A preceeding 'format.' is assumed for config.  .signature -> format.signature
Command line arguments take precedence over config options.

|----------------------------+-------------------------------------+---------|
| config  (1)                | argv  (2)                           |         |
|----------------------------+-------------------------------------+---------|
|                            |                                     | default |
|                            | --signature                         | sig2    |
|                            | --signature-file                    | file2   |
|                            | --no-signature                      | none    |
|                            | --no-signature-file                 | none    |
|                            | --signature, --signature-file       | die     |
|                            | --signature, --no-signature-file    | sig2    |
|                            | --signature-file, --no-signature    | none    |
|                            | --no-signature, --no-signature-file | none    |
| .signature                 |                                     | sig1    |
| .signature                 | --signature                         | sig2    |
| .signature                 | --signature-file                    | file2   |
| .signature                 | --no-signature                      | none    |
| .signature                 | --no-signature-file                 | sig1    |
| .signature                 | --signature, --signature-file       | die     |
| .signature                 | --signature, --no-signature-file    | sig2    |
| .signature                 | --signature-file, --no-signature    | none    |
| .signature                 | --no-signature, --no-signature-file | none    |
| .signaturefile             |                                     | file1   |
| .signaturefile             | --signature                         | sig2    |
| .signaturefile             | --signature-file                    | file2   |
| .signaturefile             | --no-signature                      | none    |
| .signaturefile             | --no-signature-file                 | default |
| .signaturefile             | --signature, --signature-file       | die     |
| .signaturefile             | --signature, --no-signature-file    | sig2    |
| .signaturefile             | --signature-file, --no-signature    | none    |
| .signaturefile             | --no-signature, --no-signature-file | none    |
| .signature, .signaturefile |                                     | die     |
| .signature, .signaturefile | --signature                         | sig2    |
| .signature, .signaturefile | --signature-file                    | file2   |
| .signature, .signaturefile | --no-signature                      | none    |
| .signature, .signaturefile | --no-signature-file                 | sig1    |
| .signature, .signaturefile | --signature, --signature-file       | die     |
| .signature, .signaturefile | --signature, --no-signature-file    | sig2    |
| .signature, .signaturefile | --signature-file, --no-signature    | none    |
| .signature, .signaturefile | --no-signature, --no-signature-file | none    |
|----------------------------+-------------------------------------+---------|


Thanks,
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
