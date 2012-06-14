From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] git-blame.el: Do not use goto-line in lisp code
Date: Thu, 14 Jun 2012 00:08:54 -0500
Message-ID: <20120614050854.GG27586@burratino>
References: <20120610073803.GA29461@burratino>
 <1339329484-12088-1-git-send-email-wence@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>,
	git@vger.kernel.org, davidk@lysator.liu.se, user42@zip.com.au,
	osv@javad.com
To: Lawrence Mitchell <wence@gmx.li>
X-From: git-owner@vger.kernel.org Thu Jun 14 07:09:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sf2JT-0002Qs-MC
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 07:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923Ab2FNFJC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jun 2012 01:09:02 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:52163 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab2FNFJA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 01:09:00 -0400
Received: by gglu4 with SMTP id u4so1074607ggl.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 22:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=24ivhu4CgWbqpo4R+dojdKU3zZi9gd302OJCvuhLz6c=;
        b=iy1KFJ0xByvR+Mxl7vBZ0xzLktMzD5LUS3VX1Cv15Np8YSxZv+qvD93YxWhAAjw4Ab
         CFh8qBEUAWfbj/VnmQIbOav4FgETqj7fLz0+DRd8c1k9Bdyb1AdD6df47EKdWrnMC064
         XdhyBdpU8gNXMljFOH46lZXyKsGheYVVWmNhtQzUNFqvyl4IFbN8p9gHe2qTtAl3Mauj
         bHLOFMeLthdSi+lkfwc5XdphyRGW87i5sO70Tqk9xEjO6N7/Kq77f1qUfGclVWtKlPqt
         8cJXRcJRrVJnxaDz7idm5ons1uR6hG9T164xswT2xU8hm9sao4afH0/cUDJXnfl8fOCd
         w74A==
Received: by 10.236.46.74 with SMTP id q50mr570489yhb.30.1339650539587;
        Wed, 13 Jun 2012 22:08:59 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id v61sm16917331yhi.17.2012.06.13.22.08.57
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 22:08:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1339329484-12088-1-git-send-email-wence@gmx.li>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199969>

Hi Lawrence,

Lawrence Mitchell wrote:

> From: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>
>
> goto-line is a user-level command, instead use the lisp-level
> construct recommended in Emacs documentation.
[...]
> Here we go, all R=C3=BCdiger's changes look sensible, I've split them=
 into bits though

Thanks for looking them over.

Would you mind indulging my curiosity a little by describing what bad
behavior or potential bad behavior this change prevents?

Even without that information, I'm all for applying this patch, since
it seems to be what all the people who know elisp recommend. :)

Regards,
Jonathan

(patch kept unsnipped for convenience)
> diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
> index 37d797e..5428ff7 100644
> --- a/contrib/emacs/git-blame.el
> +++ b/contrib/emacs/git-blame.el
> @@ -389,7 +389,8 @@ See also function `git-blame-mode'."
>      (set-buffer git-blame-file)
>      (let ((inhibit-point-motion-hooks t)
>            (inhibit-modification-hooks t))
> -      (goto-line start-line)
> +      (goto-char (point-min))
> +      (forward-line (1- start-line))
>        (let* ((start (point))
>               (end (progn (forward-line num-lines) (point)))
>               (ovl (make-overlay start end))
