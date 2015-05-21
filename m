From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Troubleshoot clone issue to NFS.
Date: Thu, 21 May 2015 21:31:41 +0700
Message-ID: <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Thu May 21 16:32:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvRWC-0005u5-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 16:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687AbbEUOcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 10:32:14 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36876 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667AbbEUOcL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 10:32:11 -0400
Received: by igbsb11 with SMTP id sb11so9943813igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GE7GSSnH5PeplDVZJ2WwAukiG5lxdAO52ObTHFZitOo=;
        b=jIyjm0W14P1lHAx/YwpMLdDnQckhIrTTpQwj8eqkm88/wwdJC/sLmj9byB27MumDrd
         vKBPOIeSa0j5rnf0bf8AAk8O9fYiwQha8KqRJdgAhvVp1eAEW002f71GGsatmqQnZsfz
         RJQWJqZGy8X56UV20Dw01lzfVVeb3bog4rhJ0TEFYEhgGmxzJJBSRfOayvzjng+x3TPB
         Ca4DH1KD7/H6L8AeHqpOmzPz0SEqKO47lOoj9EE7nU6jcDRzFV5nsN+Jv1xysszOdF9x
         Ma+bRv3yy96lvh4S0/cG+Twf/fKcvPu43q9qHXumwqe5QGLhqOqtnSylEj4Ru4Z4mxxZ
         HMhQ==
X-Received: by 10.50.45.103 with SMTP id l7mr4235306igm.41.1432218731317; Thu,
 21 May 2015 07:32:11 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Thu, 21 May 2015 07:31:41 -0700 (PDT)
In-Reply-To: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269597>

On Thu, May 21, 2015 at 8:13 PM,  <steve.norman@thomsonreuters.com> wrote:

> So there appears to be a change in 1.8.4.2 that made this issue appear for me.  Looking at the release notes the only thing that I can see that might be related could be:
>
> * When an object is not found after checking the packfiles and then
>    loose object directory, read_sha1_file() re-checks the packfiles to
>    prevent racing with a concurrent repacker; teach the same logic to
>    has_sha1_file().

That would be commit 45e8a74 (has_sha1_file: re-check pack directory
before giving up - 2013-08-30). Maybe you can try the version without
that commit to confirm. In case an object is not found pack directory
is re-read again, which might cause some increased load on nfs.
has_sha1_file() not finding the object should not happen often.. Maybe
you could do an strace (following forks) on the "git clone" process to
see if readdir() is really called a lot?
-- 
Duy
