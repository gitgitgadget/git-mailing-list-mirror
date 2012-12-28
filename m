From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 16/19] pathspec.c: move reusable code from builtin/add.c
Date: Fri, 28 Dec 2012 20:45:00 +0000
Message-ID: <CAOkDyE8vSyT=eJ4FxRwYgz7Jzqu1+0LSzxtq9iSSzJEgTD1M0g@mail.gmail.com>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
	<1356575558-2674-17-git-send-email-git@adamspiers.org>
	<7v8v8hj4t0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 21:45:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tognx-0003kx-Ta
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 21:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab2L1UpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 15:45:04 -0500
Received: from mail-we0-f169.google.com ([74.125.82.169]:62418 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab2L1UpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 15:45:01 -0500
Received: by mail-we0-f169.google.com with SMTP id t49so5199126wey.0
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 12:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=KfYs1TOGl33DL16oOy7pNI/SaRsGYektipXvn4iAr38=;
        b=BxllhHra2c+Nfjjs05d/5HN+jpwK7Cj6iTTMOfbagg3UW3XQ7k+EZzNdZtqeB+Crdb
         sBxWXGDp/41d+NnmkHLmzcxNu1loGi5cimuRr9+xT8yjRnhl2v0y9xrWnpBSUUQJO1qF
         wYlSPbDNuymBQZ7eSNsNOVwln7xTMFLoP6S7b2prY0hxk7jXEnKgrxYT3z4GTUuX3UVC
         Y1GPSyEB41q4FitoLU8DfyTLFUUxO9WC/RajGFQEhlaCvu+So9dTusoDTDlW7yN1A41r
         HPpbCZh2BIgoS0zS8lw+CHyX+5siUHGNz+wqTuwFaiTDEewiSA8kJ9kEwT45j5OkCQwT
         kNcw==
Received: by 10.194.88.98 with SMTP id bf2mr55600590wjb.49.1356727500344; Fri,
 28 Dec 2012 12:45:00 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Fri, 28 Dec 2012 12:45:00 -0800 (PST)
In-Reply-To: <7v8v8hj4t0.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: hUWLVB6m_njpVPMyWtdy9MKRiXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212262>

On Fri, Dec 28, 2012 at 8:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> diff --git a/pathspec.h b/pathspec.h
>> new file mode 100644
>> index 0000000..8bb670b
>> --- /dev/null
>> +++ b/pathspec.h
>> @@ -0,0 +1,5 @@
>> +extern char *find_used_pathspec(const char **pathspec);
>> +extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
>> +extern const char *treat_gitlink(const char *path);
>> +extern void treat_gitlinks(const char **pathspec);
>> +extern const char **validate_pathspec(const char **argv, const char *prefix);
>
> Protect this against multiple inclusion with "#ifndef PATHSPEC_H".

Yep good idea, how should I submit this?  It will cause a trivially
resolvable conflict with the next patch in the series (17/19):

  pathspec.c: extract new validate_path() for reuse

but I'd prefer not to re-roll 16--19 when just 16 and 17 are sufficient.
