From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/5] parse-options: Allow PARSE_OPT_NOARG in integer
 arguments
Date: Fri, 20 Aug 2010 22:39:16 -0500
Message-ID: <20100821033916.GA2206@burratino>
References: <1282331702-5115-1-git-send-email-artagnon@gmail.com>
 <1282331702-5115-2-git-send-email-artagnon@gmail.com>
 <7vlj81awtc.fsf@alter.siamese.dyndns.org>
 <20100820200148.GE6211@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 05:41:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omexw-0000Jf-2u
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 05:41:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303Ab0HUDll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 23:41:41 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47008 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab0HUDlj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 23:41:39 -0400
Received: by gxk23 with SMTP id 23so1523580gxk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 20:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=b91rXW2ueZhW6fsrWfW4fS2eHM1pCGIMhZ+Hx9e2SSw=;
        b=L51xPJLSr3lqF9LPzD0NTjeSSjalnOKurZHiH+FZFM/4awYqa/ozUpR1yz/WJCIPw3
         GAQ6xwfKak9t8tUX9JhaQ5DTT56jRC//TSun+yEqn5yUhX1+4oxiVY00n41qW+ypo2ad
         zjx8/934HOvSmiYzlS8aUK1KLtXnlLyE+Zdgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fiBbJmAxh7sKqaOZcT7zEY4UsgZ9zrldoNG8ZWsqRMQXCkxu9OIWJVwpikk0eJ7P+h
         jh8dVK9BTsV7OklmeyTDUNB+rBC0JFtsyyB/NanTTSJ+K70J+3gqwqBrGCvjSvnqjwad
         TaFCu+YGBtoetN6N6eJXEwxhqn7z7tBGknXp8=
Received: by 10.100.91.1 with SMTP id o1mr2545109anb.186.1282362098461;
        Fri, 20 Aug 2010 20:41:38 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id c19sm5713761ana.2.2010.08.20.20.41.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 20:41:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820200148.GE6211@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154094>

Hi Ram,

[rearranged for convenience]
Ramkumar Ramachandra wrote:

> Let's say I want to have an option that takes an
> integer argument, say `foo`. To set it to the integer argument 42, I
> can say `--foo=42`. To set it to its default value, I could earlier
> say `--foo=`. With this patch I can simply say `--foo`. Makes sense?

I think you want OPTARG ("optional argument").

What your patch would allow is using OPTION_INTEGER for boolean
options, where people use OPT_SET_INT now.  Maybe that would be a good
cleanup, but I am not convinced it is worth the churn.

> Junio C Hamano writes:

>> Doesn't NOARG mean "Do not take an argument, if you give me an argument
>> that is an error"?
>
> Oh, does it mean that?

Yes.

-- 8< --
Subject: parse-options: clarify PARSE_OPT_NOARG description

Here "takes no argument" means "does not take an argument".  The
latter phrasing might make it clearer that PARSE_OPT_NOARG does not
make an option with an argument that can optionally be left off.

Noticed-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/parse-options.h b/parse-options.h
index 7435cdb..d982f0f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -69,7 +69,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  * `flags`::
  *   mask of parse_opt_option_flags.
  *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
- *   PARSE_OPT_NOARG: says that this option takes no argument
+ *   PARSE_OPT_NOARG: says that this option does not take an argument
  *   PARSE_OPT_NONEG: says that this option cannot be negated
  *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, and
  *                     shown only in the full usage.
-- 
