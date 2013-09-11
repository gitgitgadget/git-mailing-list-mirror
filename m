From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v2] configure.ac: move the private git m4 macros to a
 dedicated directory
Date: Wed, 11 Sep 2013 19:03:57 +0100
Message-ID: <5230B08D.6080109@gmail.com>
References: <1378914417-32605-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 20:04:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJols-00018Q-4B
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 20:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721Ab3IKSED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 14:04:03 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43992 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582Ab3IKSEB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 14:04:01 -0400
Received: by mail-wi0-f172.google.com with SMTP id c10so2509485wiw.17
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xFC9LjnjfBqTy4jcvbdTEQ4Ff2aj8SV9iZ4niHA/hV0=;
        b=i1oS0vldDeRSOgguoN9YUE7fu13PRfUHMahStls9BRo7iYwCXdSMsXbJJZKRb72QuT
         HGfvYCUhjVXngSIuUHDpUVNUGKys7mL85fwtk5n3SS0cKXuq6gCSR9kuR6LuT2yY0TVr
         61Q7GSX8z7v9HZLjHtO7AFij1Pp0Qn2QTN3QfKZXXk+FvpYcZfyCmji3ppffb1NfyvFA
         iOOzzjdHT8ZWZf+vnk5qncJIfY/a80b5v0vpzSYmfVx7ZoxLUtWvONivhqadXyYJgIib
         WOSURJdKsKwzhJoxZtNbhPwsA8gEYo7IyYaOjE3A7MqxwSlUx06KCC7EiVZ3F5ane+Ox
         fcVA==
X-Received: by 10.194.75.165 with SMTP id d5mr2608048wjw.18.1378922640224;
        Wed, 11 Sep 2013 11:04:00 -0700 (PDT)
Received: from marcovaldo.dub.corp.google.com ([2620:0:1040:205:8a51:fbff:fe5c:1cad])
        by mx.google.com with ESMTPSA id jf2sm12352917wic.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 11:03:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <1378914417-32605-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234588>

Hi Elia.  Sorry, but I have to give my NAK to this patch.

On 09/11/2013 04:46 PM, Elia Pinto wrote:
> Git use, as many project that use autoconf, private m4 macros.
>
> When not using automake, and just relying on autoconf, the macro
> files are not picked up by default.
>
> A possibility, as git do today, is to put the private m4 macro
> in the configure.ac file, so they will copied over the final configure
> when calling autoreconf(that call also autoconf).
> But this makes configure.ac difficult to read and maintain,
> especially if you want to introduce new macros later. By separating
> the definitions of the macros from configure.ac file the build system
> would be more modular.
>
In which sense are we being more modular exactly?  After all:

   - the configure.ac of Git is the only user of these macros,

   - using m4_include doesn't offer any performance improvement, and

   - m4 doesn't offer any namespace granularity anyway.

So it seems to me that this patch only adds extra indirections without
adding any real benefit.

> Starting from version 2.58, autoconf provide the macro AC_CONFIG_MACRO_DIR
> to declare where additional macro files are to be put and found by aclocal.
> The argument passed to this macro is commonly m4. Despite the documentation,
> autoconf do nothing with it, only aclocal can use directly if invoked by
> -I m4 or indirectly using automake. But autoreconf don't invoke aclocal
> in this way. So in summary you can not use this macro in a useful
> way if you only use autoconf, as git does.
>
> Another historical possibility is to list all your macros in acinclude.m4.
> This file will be included in aclocal.m4 when you run aclocal, and its macro(s)
> will henceforth be visible to autoconf. However if it contains numerous macros,
> it will rapidly become difficult to maintain, and for git this don't provide
> any benefits or very little.
>
> The actual autotool documentation recommend to write each
> macro in its own file and gather all these files in a separate directory.
>
Where exactly id you find that recommendation?  If the autotools docs tell
to do so *unconditionally*, they are wrong and should be fixed.  In fact,
even the configure.ac from Automake itself keeps definition of private
macros in configure.ac...

> Given the limitations i mentioned earlier, the only possibility is to use the m4_include
> for including every macro file. The m4_include directive works quite like the
> #include directive of the C programming language, and simply copies over the content
> of the file(s).
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is a second version of this patch http://article.gmane.org/gmane.comp.version-control.git/231984.
> The first was plain wrong, my bad. I am sorry for the long delay.
> Sure it is something low-hanging fruit
>
>
>   configure.ac                      |  148 +++----------------------------------
>   m4/git_arg_set_path.m4            |   14 ++++
>   m4/git_check_func.m4              |   13 ++++
>   m4/git_conf_append_path.m4        |   30 ++++++++
>   m4/git_conf_subst.m4              |   10 +++
>   m4/git_conf_subst_init.m4         |   15 ++++
>   m4/git_parse_with.m4              |   22 ++++++
>   m4/git_parse_with_set_make_var.m4 |   20 +++++
>   m4/git_stash_flags.m4             |   15 ++++
>   m4/git_unstash_flags.m4           |   13 ++++
>   10 files changed, 162 insertions(+), 138 deletions(-)
>   create mode 100644 m4/git_arg_set_path.m4
>   create mode 100644 m4/git_check_func.m4
>   create mode 100644 m4/git_conf_append_path.m4
>   create mode 100644 m4/git_conf_subst.m4
>   create mode 100644 m4/git_conf_subst_init.m4
>   create mode 100644 m4/git_parse_with.m4
>   create mode 100644 m4/git_parse_with_set_make_var.m4
>   create mode 100644 m4/git_stash_flags.m4
>   create mode 100644 m4/git_unstash_flags.m4
>
 > [SNIP]
 >

Regards,
   Stefano
