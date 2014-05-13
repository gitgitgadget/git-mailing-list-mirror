From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/3] Add read-cache--daemon
Date: Tue, 13 May 2014 15:37:44 +0200
Message-ID: <CABPQNSbu9uVh_LZqQupG9TJe0_ggA1EmAWnk8H7+xOBvcsrcOg@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-3-git-send-email-pclouds@gmail.com>
 <CABPQNSaSDRhuQYey0ad6J0cXrCzrK1CYZQar5GgUM8g3JVmRSA@mail.gmail.com> <CACsJy8BFEtXQc7mO1pvdeQ9GMofcW0H2uJF=E6yfN4SwQWgRbw@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 15:38:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkCuc-0004Yh-9I
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 15:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760043AbaEMNiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 09:38:25 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43656 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753943AbaEMNiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 09:38:25 -0400
Received: by mail-ie0-f174.google.com with SMTP id at1so308650iec.33
        for <git@vger.kernel.org>; Tue, 13 May 2014 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=uo8eo7UYYcO71Xv7+IoFQAZQfkWUTRtwKyT3K35/egs=;
        b=yPfbKgDG9bqM7thUjSTON/WwEkTMEQuRb0M71a1dr592Xyp41qBkrP9HJeupVKpnxf
         SyMhRbTfIrCGv5AJvCkD67WlrZGkkwH7ji7/MyBtkJ1Mx7apyD6YzMTYJyTeFH8OcFlv
         hAg/TtcB6NEtKjyx9sUUa8Pey1D6iVRO/93ehJwGvPMPy+Gy0bY/ECQSlSit174aElXM
         rcbsG2Q8GD6/d56lmRYySM8hxgCaTujHbWlI23DvREiou7yvrRJP5mCa46Izq1aP9+n6
         C4gusIbV1q9VKKoYHCCNoqPXiGzYiRDwxLWW86jh6mAWA9nbbmZzVVMID73eJz/ASZ3C
         B+7w==
X-Received: by 10.50.109.202 with SMTP id hu10mr20220158igb.1.1399988304862;
 Tue, 13 May 2014 06:38:24 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 13 May 2014 06:37:44 -0700 (PDT)
In-Reply-To: <CACsJy8BFEtXQc7mO1pvdeQ9GMofcW0H2uJF=E6yfN4SwQWgRbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248782>

On Tue, May 13, 2014 at 3:01 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> What do you think is a good replacement for unix socket on Windows?
> It's only used to refresh the cache in the daemon, no sensitive data
> sent over, so security is not a problem. I'm thinking maybe just
> TCP/IP server, but that's going to be a system-wide daemon.. Perhaps
> the windows daemon could just monitor $GIT_DIR/index and refresh it?

Windows has support for Named Pipes, which seems like the right kind
of communication channel. However, the programming model differs quite
a bit from unix-sockets:

http://msdn.microsoft.com/en-us/library/windows/desktop/aa365594%28v=vs.85%29.aspx
