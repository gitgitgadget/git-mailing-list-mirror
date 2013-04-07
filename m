From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Sun, 7 Apr 2013 16:48:10 -0700
Message-ID: <20130407234810.GG19857@elie.Belkin>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:48:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5rb-0000sy-BD
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934508Ab3DGXsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 19:48:19 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:37245 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934500Ab3DGXsS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 19:48:18 -0400
Received: by mail-pd0-f179.google.com with SMTP id x11so2904535pdj.10
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 16:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=vEVxXxWnjUCVvfVF5MHwhcWZ1RS4gWbjvCbF5nw56wM=;
        b=RQGZVkdngZvLi+zF/644ERiqehHUswHa2L7HmbRSlgEZWItfKtg0Hm2/kg3ppQVcFy
         a35opRSfDGYk5CX3+LW5RsviU24CBsBNC0aaC9T7C50qPLRWVR3RwAug0ftk+nIlniPz
         zAbaLe/o7oMiU3/XqcdbTKOYA6ZzceqRXq24QsF3UFMsZNPLE/Cn48WS81ycRmfMY98W
         jBr1hrqhn86nmcRWmEvTjHfPx2bh/30Q4btjSECyAcHcf9LkBtch2ln1e+mTVQxqcSnh
         krZ5APMkrVg/slr+JD4Xt+oQwRjr6LGrfbMQtWwl564R+pURZbkb/frAwDIYVzAVx8q0
         7KYw==
X-Received: by 10.66.231.5 with SMTP id tc5mr14000160pac.144.1365378497969;
        Sun, 07 Apr 2013 16:48:17 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id lo3sm13913239pab.19.2013.04.07.16.48.15
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 16:48:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1365376629-16054-1-git-send-email-aaron@schrab.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220386>

Hi Aaron,

Aaron Schrab wrote:

> Do not report an argument to clone's --reference option is not a local
> directory.  Nothing checks for the actual directory so we have no way to
> know if whether or not exists.  Telling the user that a directory doesn't
> exist when that isn't actually known may lead him or her on the wrong
> path to finding the problem.

I don't understand the above explanation.  Could you give an example?

[...]
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -241,7 +241,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
>  		free(ref_git);
>  		ref_git = ref_git_git;
>  	} else if (!is_directory(mkpath("%s/objects", ref_git)))
> -		die(_("reference repository '%s' is not a local directory."),
> +		die(_("reference repository '%s' is not a local repository."),

"is_directory" calls stat and checks if its target is a directory.  Is
the problem that "/path/to/repo.git" might be a directory but
"/path/to/repo.git/objects" may not?

Would it make sense for the message to say something like the
following?

	fatal: alternate object store '/path/to/repo.git/objects' is not a local directory

Thanks and hope that helps,
Jonathan
