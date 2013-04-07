From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] clone: Allow repo using gitfile as a reference
Date: Sun, 7 Apr 2013 16:51:12 -0700
Message-ID: <20130407235112.GH19857@elie.Belkin>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <1365376629-16054-2-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:50:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5rc-0000sy-QS
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934548Ab3DGXvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 19:51:20 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:47999 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934473Ab3DGXvU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 19:51:20 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so2363330dak.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 16:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=rCaxs2QcBpcvjrEUs9tnpQulWl27BGLfxzGiLPhl850=;
        b=NBW0oGgQpRR7LHu0qH6A/W7xjrpBQXHiufcTYFDIRjk0cl/g6LyqTBXSIt8woI9gXS
         RzRka1SwOc2WVDeBUZR5F1DOQ2lMdce5RGqDJEENqt3vVp5DD2Z0XaRWsMSoARhgCp9T
         W7HVfcIrIoMBnPEAICUF6WZfes2Byca6RiIm1cnqK0i7NuHFL/zQW7pdlADx50kfhbFx
         dl0+zFzUVWDs3vXK/jZNSbO4NQf9yjAySLk+E0O/mURHO0xJDCp1kJgtQ+KPo2JrNdOy
         1XzfQKKwVMaTDFuPbzesO6vEEnphSBGAVG+iVLNRNW5Kib8cYViV9hZV9/WmT5iCh7Ua
         OHCg==
X-Received: by 10.66.250.230 with SMTP id zf6mr32517509pac.153.1365378679375;
        Sun, 07 Apr 2013 16:51:19 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id fc8sm34073863pad.21.2013.04.07.16.51.17
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 16:51:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365376629-16054-2-git-send-email-aaron@schrab.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220398>

Aaron Schrab wrote:

> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -231,12 +231,19 @@ static void strip_trailing_slashes(char *dir)
>  
>  static int add_one_reference(struct string_list_item *item, void *cb_data)
>  {
> -	char *ref_git;
> +	char *ref_git, *repo;
[...]
> +	repo = (char *)read_gitfile(mkpath("%s/.git", ref_git));

Why not make repo a "const char *" and avoid the cast?  The above
would seem to make it too tempting to treat the return value from
read_gitfile() as a mutable buffer instead of a real_path string that
should be copied asap.

Hope that helps,
Jonathan
