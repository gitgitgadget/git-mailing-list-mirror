From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 06/15] t3600 (rm): add lots of missing &&
Date: Fri, 1 Oct 2010 05:48:23 -0500
Message-ID: <20101001104823.GD6816@burratino>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-7-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 12:56:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1dHt-0002nM-KK
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 12:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756208Ab0JAKvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 06:51:32 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39813 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab0JAKvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 06:51:31 -0400
Received: by ywh1 with SMTP id 1so937331ywh.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 03:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6IhJVdJYjPscdSS168kfXXqa8SLzRMjudtWsTfYxK+g=;
        b=gsv6ufVP3gJCAQb0ecfDMj/BUWKfB6d7LK6DJBEy5wTFBgYjUmh82Tc5pcpctGu8yl
         YHHuqtBE+hAR9Kj7z8XsdQ90e+ZhIQrd1Y3Iiz31oN1VItM9ofx3jI0IrZ+oUWLjUipF
         DQX1tDhY+9o0eV9/DmFHv5j9hx1d08S2J5fGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=V7TsqYILljLjrw5rFQUf9hQ8+3uvhUhNl9ditIZp4KPoiQ/FLsuRyweeKo2U1BGTyz
         DXHl4GQZ2GbNa6eQFoZBmuyzrH7E8ocsGhFJXpdfiFkpt9d8ojPlMMnRDWE8Db0QEhdn
         JWT2/fzRE2+/N4UzWw5S4PinNyyAZpaQynkM8=
Received: by 10.150.32.16 with SMTP id f16mr804762ybf.61.1285930290501;
        Fri, 01 Oct 2010 03:51:30 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id p1sm728398ybk.1.2010.10.01.03.51.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 03:51:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285542879-16381-7-git-send-email-newren@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157742>

Elijah Newren wrote:

> Also delete unnecessary, failing code and add some test_when_finished
> calls to make sure tests clean up after themselves.

I don't understand this one.

If tests clean up after themselves, each will restore some pristine
state as though (at least as far as the other tests care) it had never
run at all, right?

> --- a/t/t3600-rm.sh
> +++ b/t/t3600-rm.sh
> @@ -38,37 +38,33 @@ test_expect_success \
>  
>  test_expect_success \
>      'Test that git rm --cached foo succeeds if the index matches the file' \
> -    'echo content > foo
> -     git add foo
> +    'echo content > foo &&
> +     git add foo &&
>       git rm --cached foo'

Before this runs: foo is empty, absent from index.
After it runs: foo has content, still absent from index.
Requires: nothing.
 
>  test_expect_success \
>      'Test that git rm --cached foo succeeds if the index matches the file' \
> -    'echo content > foo
> -     git add foo
> -     git commit -m foo
> -     echo "other content" > foo
> +    'echo content > foo &&
> +     git add foo &&
> +     git commit -m foo &&
> +     echo "other content" > foo &&
> +     test_when_finished "git checkout HEAD -- foo" &&
>       git rm --cached foo'

Before this runs: foo has content, absent from index.
After this runs (without patch): foo has other content, absent from index.
After this runs (with patch): foo has content, matching index.
Requires: nothing.

>  test_expect_success \
>      'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
> -     echo content > foo
> -     git add foo
> -     git commit -m foo
> -     echo "other content" > foo
> -     git add foo
> -     echo "yet another content" > foo
> +     echo "other content" > foo &&
> +     git add foo &&
> +     echo "yet another content" > foo &&
> +     test_when_finished "git checkout HEAD -- foo" &&
>       test_must_fail git rm --cached foo
>  '

Before this runs: see above.
After this runs (without patch): foo has yet another content, absent from index.
After this runs (with patch): foo has content, matching index.
Requires (without patch): nothing.
Requires (with patch): HEAD:foo is content.

[etc]

So if I understand correctly, this sacrifices the ability to
skip individual tests.  What does one gain in return?
