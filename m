From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: reuse bzrlib transports when possible
Date: Sat, 7 Sep 2013 19:27:42 -0500
Message-ID: <CAMP44s3Vw4GX+yL22F49uKFZcEvYmXC7nT9TCGW_jybhFHo1Og@mail.gmail.com>
References: <1378598300-22737-1-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 02:27:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VISqy-0005Ef-L8
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 02:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021Ab3IHA1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 20:27:44 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:44059 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab3IHA1o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 20:27:44 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so3946659lab.3
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 17:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oq51mN8yCMhygpg7ZNrHIDpUVuSQyOIqf4ta2nCU2TM=;
        b=f+oeDPwdxQYeW+YI3bEyiyNGXJZXjwp59tQx69MzKy5TbRMJCCDGIclKOzBEiZf6t8
         enxPxrhoQ7Ulz0a32l0FNUrbY7ZnmMXhTqXDtIVtZdlH+Nq9epwd33p6xJ+R6/pdRZJi
         Smr1kaibjPbPwSJellqqi3WR9AdrJyAW91wJ3PC47Y+L7wJ/0JC5suG/Q8fzKW1NU+cx
         ojrsULRl4+ky1768ZXX3MTwdzbmfA7TIZcDYAKss3zbmdjWBXo2ab4TKelE5/vgU4FFT
         LZQV2ao1eL8miVwcXMeC5VKJZrDIC7zgitP1qmG6zGd0bHdZ4mbja13OaMi0g4s0PCbY
         5Tyg==
X-Received: by 10.152.29.201 with SMTP id m9mr9319001lah.6.1378600062653; Sat,
 07 Sep 2013 17:27:42 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 17:27:42 -0700 (PDT)
In-Reply-To: <1378598300-22737-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234150>

On Sat, Sep 7, 2013 at 6:58 PM, Richard Hansen <rhansen@bbn.com> wrote:
> Pass a list of open bzrlib.transport.Transport objects to each bzrlib
> function that might create a transport.  This enables bzrlib to reuse
> existing transports when possible, avoiding multiple concurrent
> connections to the same remote server.
>
> If the remote server is accessed via ssh, this fixes a couple of
> problems:
>   * If the user does not have keys loaded into an ssh agent, the user
>     may be prompted for a password multiple times.
>   * If the user is using OpenSSH and the ControlMaster setting is set
>     to auto, git-remote-bzr might hang.  This is because bzrlib closes
>     the multiple ssh sessions in an undefined order and might try to
>     close the master ssh session before the other sessions.  The
>     master ssh process will not exit until the other sessions have
>     exited, causing a deadlock.  (The ssh sessions are closed in an
>     undefined order because bzrlib relies on the Python garbage
>     collector to trigger ssh session termination.)

Looks good to me. I'll apply in my personal repository.

-- 
Felipe Contreras
