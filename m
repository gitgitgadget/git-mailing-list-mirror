From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 3/6] Add 'resolve_gitlink_ref()' helper function
Date: Tue, 10 Apr 2007 11:38:29 +0200
Message-ID: <81b0412b0704100238l38ad3765w6c06878e2db654a7@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704092114010.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 12:42:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbCo8-0001L3-Aq
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 11:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbXDJJib (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 05:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbXDJJib
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 05:38:31 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:20274 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbXDJJia (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 05:38:30 -0400
Received: by an-out-0708.google.com with SMTP id b33so1882944ana
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 02:38:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TThMRHML5b3W8xoc3YUAO8tM6zE2RIqwVB6EKIU9fdKu5fm5Aj0M57YSujg1YO+vvEUfRgAGNIacsY05qrjdytjslRTI8TDsJK4GmwjE3XU65UWoCyVbBGdQroTTSRe2YzJCklZWxV3jobNVydG5Y6MBSHtw81mEtdlBXlw/djk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cvYbDP+Ap8vK9gfumAbXBd5pybD6GkoVrXZy4ptSJ9a42TLpCMmpoe1YZcWej7QaF0llz+0DaX/5tXNOM94o6zh0FXMGf/yiCOrMD686/ewYMbT1v+bXwCzQfFp17idsslADkSnRrwkyiOsiU6E0XDn0wfOXfx93RuV4BzPTW8Q=
Received: by 10.100.47.6 with SMTP id u6mr4695772anu.1176197910023;
        Tue, 10 Apr 2007 02:38:30 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Tue, 10 Apr 2007 02:38:29 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704092114010.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44117>

On 4/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> +int resolve_gitlink_ref(const char *path, const char *refname, unsigned char *result)
> +{
> +       int len = strlen(path), retval;
> +       char *gitdir;
> +
> +       while (len && path[len-1] == '/')
> +               len--;
> +       if (!len)
> +               return -1;
> +       gitdir = xmalloc(len + MAXREFLEN + 8);
> +       memcpy(gitdir, path, len);
> +       memcpy(gitdir + len, "/.git/", 7);

Can't a subproject be bare?
