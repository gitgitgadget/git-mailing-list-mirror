From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git smart-http do not authent to allow git ls-remote to be called anonymously
Date: Sun, 30 Sep 2012 17:53:40 -0700
Message-ID: <CAJo=hJuBHCMBv5FTh6dSkvGR=XCtKn2BRgWgTJwt6kDs49-iEg@mail.gmail.com>
References: <CAHtLG6Q+XO=LhnKw4hhwtOe2ROeDN1Kg=JN5GTQqdvYjk-Sv4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 02:54:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIUHh-0000Hf-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 02:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab2JAAyD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Sep 2012 20:54:03 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:37379 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab2JAAyB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2012 20:54:01 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so1201874qad.19
        for <git@vger.kernel.org>; Sun, 30 Sep 2012 17:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oLTed+xQ5P9712XXHoPjS6k8dJbPNx/OZkBnZ13HjsQ=;
        b=CxCq3VJTA/CLj0FJobt3MB2zoJ7P5TDRX3jSHzpWZ2EqIh/OcmDRFSLfeeGLyECte0
         bLw3IGGdWHDSIaj9qshshomqWu9w0rHde5bKx2Xq/yFEVw3q/1HHzgeX+2Mgva6f/t4a
         5UdU+86/EoioIynUSKwWaJVNsDN4f5gTDFj/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=oLTed+xQ5P9712XXHoPjS6k8dJbPNx/OZkBnZ13HjsQ=;
        b=VUl1hIpyYEp8Cv1sZFBDkEO4MWcIZSVgVLN/vUpZ67gSVwo0m6ycFx4JXQ+QhK/gCT
         Q7yoOl7iLk1yH1Q5GDRbxGqNvZLW1kymTNIgoBAyDxXYrXZMTYupiqrKThKZohLCSmea
         zdxLv8MLXEGDXQ2ySHltj6NVjqD6ln7INbqB0uhOv4+hEV27+MagHNz/XT4O/9UY2HUH
         ysxyjH6W9BxhcT9xCo+26x+pDfGxTffFwrhMUfMmiaOpNZebwp+Gl5LCaScmui0MxxQ4
         SlW2KVG3mjFWhSStNethoNPFRTdE5/FbpNFdfDQQ+I3HzWjE7oZup2eZ2+tu3Luea2wq
         o+7w==
Received: by 10.224.213.198 with SMTP id gx6mr33805452qab.9.1349052840476;
 Sun, 30 Sep 2012 17:54:00 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Sun, 30 Sep 2012 17:53:40 -0700 (PDT)
In-Reply-To: <CAHtLG6Q+XO=LhnKw4hhwtOe2ROeDN1Kg=JN5GTQqdvYjk-Sv4g@mail.gmail.com>
X-Gm-Message-State: ALoCoQlaosaBiy9yr6WncP513iJIhxXCaiielexBnmtiJXeHs4115JMYYIYe99MJ2GZkUuYCcbd3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206701>

On Sun, Sep 30, 2012 at 7:35 AM, =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@=
gmail.com> wrote:
> I use smart-http on Apache.
> If nothing to be pushed / pulled, I do not want password to be
> supplied. And allow git ls-remote to run without password
>
> *.git/info/refs?service=3Dgit-upload-pack
> *.git/info/refs?service=3Dgit-receive-pack
>
> I only need authentication on
>
> *.git/git-upload-pack
> *.git/git-receive-pack
>
> /etc/apache/httpd.conf
>
> <LocationMatch "^/git/.*/git-(upload|receive)-pack$">
>     AuthType Basic
>     AuthName "staff only"
>     AuthUserFile /etc/apache/apache.pwd
>     Require valid-user
> </LocationMatch>
>
> However this does not work. It does not ask for password at all.

This sounds like a bug in your Apache configuration. I would verify it
prompts for a password as expected before worrying about the Git
client:

  curl -v http://localhost/git/blah/git-upload-pack

should fail with a 401 requesting access to "staff only". Once this is
working, git will present authorization as necessary during the
/git-upload-pack|git-receive-pack calls.
