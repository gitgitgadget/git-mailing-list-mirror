From: Dan Langille <dlangille@sourcefire.com>
Subject: forcing a user@ into the URL if not present
Date: Wed, 22 Apr 2015 17:06:41 -0300
Message-ID: <CABU7BddjAZOk0LyybQ8phO0S4705MrZtLSYEsjzUBKUD=H++RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 22:14:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl12f-0005q5-VI
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 22:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbbDVUOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 16:14:37 -0400
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:36935 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751459AbbDVUOg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 16:14:36 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2015 16:14:36 EDT
Received: from mail-ie0-f176.google.com ([209.85.223.176]) (using TLSv1) by na3sys009aob138.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVTgBLOhbEb0fEYSNmlyQhRvLtTg+Er0T@postini.com; Wed, 22 Apr 2015 13:14:36 PDT
Received: by iecrt8 with SMTP id rt8so46372676iec.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sourcefire.com; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hpmXycgpfoMshX++wsnb+9Be4Tl7ryF/WYFomaHCRxE=;
        b=LUid0DbzFVUnXkN4GCf0x9oqa6YIKTxSyGl7x5sAAq7hhcUMQQtcy8ELW7K8b8Pwl/
         ib4tL8iXXHEQClnxB90cVdKe91Ihq8LCH9kUd7T61ZuIP8C7DgdxUi7hysR8gJZ9I+kl
         qt69yDRCs3yzJeRyKwUNQmllN7nE2gVUnPbpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=hpmXycgpfoMshX++wsnb+9Be4Tl7ryF/WYFomaHCRxE=;
        b=Uthmk6nHuwharDouw9+vfsteHQh/OxSIzFzRUOfRspnJdgGHgafQ8Ad83CoSUaK8eH
         LbNr1ryhtfMpMkHec+1tRox/9ySm1O/pNFoued9+l6rrsaKG5ybkim/Ubg7XMjwp9Z1W
         kC6dEp6YXBRCDse0ZeEXvzOEjJ++ON2+pbo5JOXKctA6T30NhUYeFzTAO8Mz5/g3CKVb
         8PdDML0ZoqmAJXJg9O0Mv2Hdq6x8wrCw017505XZtJaWh51G3byBVOv+BaU7CS1GMuGn
         7xuL3CYQ7g1r+wXxgY5MjYPiZgYc6Uk4X4WVP/xUAT7ouSBzFWsfK65mrlTCfgDx9J8C
         2xqA==
X-Received: by 10.107.37.132 with SMTP id l126mr38578404iol.42.1429733202138;
        Wed, 22 Apr 2015 13:06:42 -0700 (PDT)
X-Gm-Message-State: ALoCoQmb+kaU3o37qqm1/HiOyuGu6MGAMSkfoLac06M5jo9lB6cGQyPdtvEw/TVEwZuqVxVaJiWLESSFH1RTDHSGYRRxFWzcwLJ24mZqyUSSZTYFcRTsVD/2lHldfBSKlnV9/2JEWwnMDQM0SRw6ku4LFNBZrVj0Zg==
X-Received: by 10.107.37.132 with SMTP id l126mr38578380iol.42.1429733201938;
 Wed, 22 Apr 2015 13:06:41 -0700 (PDT)
Received: by 10.107.137.95 with HTTP; Wed, 22 Apr 2015 13:06:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267636>

Hello,

I'm using git 2.3.2 with Kerberos for authentication and gito-lite for
authorization.

This works:

$ git clone https://dvl@ repo.example.org/git/testing
Cloning into 'testing'...
warning: You appear to have cloned an empty repository.
Checking connectivity... done.

My goal: have it work without supplying dvl@ as shown here:

$ git clone https://repo.example.org/git/testing
Cloning into 'testing'...
Username for 'https://repo.example.org':

I don't want to be prompted for a password.  I want Kerberos to kick in.

Following http://git-scm.com/docs/gitcredentials, the following seems to
have nil effect.  Anyone used this feature already?

  git config --global credential.https://repo.example.org.username dvl

$ cat ~/.gitconfig
[credential "https://repo.example.org"]
username = dvl
[http]
sslCAInfo = /usr/local/etc/trusted-certificates.pem

With the above, I still get prompted for a password

Given my use of Kerberos for authorization, is this option feasible?

Should I be taking a different approach?

Thank you.

-- 
Dan Langille
Infrastructure & Operations
Talos Group
Sourcefire, Inc.
