From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 2/2] git-p4: handle "Translation of file content failed"
Date: Tue, 15 Sep 2015 07:43:54 +0100
Message-ID: <55F7BE2A.80609@diamand.org>
References: <1442249728-89494-1-git-send-email-larsxschneider@gmail.com> <1442249728-89494-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 08:44:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbjyJ-00009U-6t
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 08:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbbIOGn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 02:43:59 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:32938 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbbIOGn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 02:43:57 -0400
Received: by wiclk2 with SMTP id lk2so13931938wic.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=YhxPhEVXIIARUWIsrBLEUTliImsADDs5SB49zP6nDhA=;
        b=ShwhI3hi+1TfXrbTbS7JxaGEXNY8KvN//h76vE08Du1TczgErEUkWK03Xnza/WkQ30
         /BNKFOK6zLJzBKN+huoDFgflNp52/dT9p+uSx/2ySuERwCfqWIoH9ks/vHbjQjuBoKgf
         TfRVqGnm35xZUzBjpZlRrOuuHJb+nC+vOeo6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=YhxPhEVXIIARUWIsrBLEUTliImsADDs5SB49zP6nDhA=;
        b=Md+bFHneoSpwE3dewk7eAlYhQoC/FQOZbEEzmwlzRWARJKD/CH3nPPDcwOuMvwao1i
         wVVUuchaqjyPfep0q/KFCYpt4OMuQYiTFv0NnecbUhQa8eUgtJDurUgnepy1E830Az/g
         UhyCc6tWSY1LjaeB6MMzLu0BROMFLOlNIjHCiizMy9FiHMa1+vCPGZ8m+LvzkIZkr6lQ
         UbjDya+EQGfmOHuKRD1+X8Y1dd7vgNBRLW5rpEHI5s9QcdOAOf+BVHFaiLJBVc4rOGCI
         xQrBv+F/TCPScpLxTJjwdhVzR/uyjPBpmpcxwDIU7d/nquOHC8ckdrv9GuNhjJJPxNRx
         +usw==
X-Gm-Message-State: ALoCoQkvRXyKs0L3v4ITdKHj6H1WRBU11evWeZLAz7kp+b5kr9NJ9cytoDHPMxRliC6edkygpFh1
X-Received: by 10.180.102.226 with SMTP id fr2mr4194546wib.3.1442299436597;
        Mon, 14 Sep 2015 23:43:56 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id h8sm18042362wib.21.2015.09.14.23.43.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2015 23:43:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1442249728-89494-3-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277887>

On 14/09/15 17:55, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> A P4 repository can get into a state where it contains a file with
> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4

Sorry - what's a BOM? I'm assuming it's not a Bill of Materials?

Do we know the mechanism by which we end up in this state?



> attempts to retrieve the file then the process crashes with a
> "Translation of file content failed" error.
>
> Fix this by detecting this error and retrieving the file as binary
> instead. The result in Git is the same.
>
> Known issue: This works only if git-p4 is executed in verbose mode.
> In normal mode no exceptions are thrown and git-p4 just exits.

Does that mean that the error will only be detected in verbose mode? 
That doesn't seem right!

>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   git-p4.py | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..5ae25a6 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -134,13 +134,11 @@ def read_pipe(c, ignore_error=False):
>           sys.stderr.write('Reading pipe: %s\n' % str(c))
>
>       expand = isinstance(c,basestring)
> -    p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
> -    pipe = p.stdout
> -    val = pipe.read()
> -    if p.wait() and not ignore_error:
> -        die('Command failed: %s' % str(c))
> -
> -    return val
> +    p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
> +    (out, err) = p.communicate()
> +    if p.returncode != 0 and not ignore_error:
> +        die('Command failed: %s\nError: %s' % (str(c), err))
> +    return out
>
>   def p4_read_pipe(c, ignore_error=False):
>       real_cmd = p4_build_cmd(c)
> @@ -2186,10 +2184,17 @@ class P4Sync(Command, P4UserMap):
>               # them back too.  This is not needed to the cygwin windows version,
>               # just the native "NT" type.
>               #
> -            text = p4_read_pipe(['print', '-q', '-o', '-', "%s@%s" % (file['depotFile'], file['change']) ])
> -            if p4_version_string().find("/NT") >= 0:
> -                text = text.replace("\r\n", "\n")
> -            contents = [ text ]
> +            try:
> +                text = p4_read_pipe(['print', '-q', '-o', '-', '%s@%s' % (file['depotFile'], file['change'])])
> +            except Exception as e:

Would it be better to specify which kind of Exception you are catching? 
Looks like you could get OSError, ValueError and CalledProcessError; 
it's the last of these you want (I think).

> +                if 'Translation of file content failed' in str(e):
> +                    type_base = 'binary'
> +                else:
> +                    raise e
> +            else:
> +                if p4_version_string().find('/NT') >= 0:
> +                    text = text.replace('\r\n', '\n')
> +                contents = [ text ]

The indentation on this bit doesn't look right to me.

>
>           if type_base == "apple":
>               # Apple filetype files will be streamed as a concatenation of
>

Luke
