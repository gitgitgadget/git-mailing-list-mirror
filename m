From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: reuse bzrlib transports when possible
Date: Sat, 7 Sep 2013 19:30:10 -0500
Message-ID: <CAMP44s0uHs8=r1eh2D-jdj563co5y7Rr1_6u=xoZDC52A6CPTQ@mail.gmail.com>
References: <1378598300-22737-1-git-send-email-rhansen@bbn.com>
	<522BBE87.10206@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 02:30:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIStN-0006uK-Db
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 02:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099Ab3IHAaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 20:30:13 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:37778 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab3IHAaM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 20:30:12 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so3928273lab.32
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 17:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2VwqdyUXv8Iu6t/gtqZdMvJwURai10WdUXfz65TTZ5s=;
        b=B8LsWBi9tueeIVhDz7p7wleJg9JkjZOhSKudMicrh8sKwalc0xeo5J10sOkuI+biHC
         xu9Oed13S9V/8Z2opV9o04Mw+VTdpaRL3s2bYq6qjCMWuaBmCNN9CsVxHJO4d+rkhKqJ
         lIzXFpxmytGH/lNJ+FhSs3MhiOMVT/JYiPfyGXMQ5HHrBhePdjIgP6FeLBX0M+qiOhEl
         DcpTYcSsCIYmCdteqt9aNUTRVzXdK6cbvjZqY57LSDuvdTGoa85cTf//vGhuLV+r4BJg
         743FEdp6e6TdgbtMfLwH0EEtmDVT7tCN803LI9AXlLjSJM/f/nDJe0i+dWIyTDudvLrT
         zl3w==
X-Received: by 10.112.64.36 with SMTP id l4mr9359913lbs.15.1378600210704; Sat,
 07 Sep 2013 17:30:10 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 17:30:10 -0700 (PDT)
In-Reply-To: <522BBE87.10206@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234151>

On Sat, Sep 7, 2013 at 7:02 PM, Richard Hansen <rhansen@bbn.com> wrote:
> On 2013-09-07 19:58, Richard Hansen wrote:
>> Pass a list of open bzrlib.transport.Transport objects to each bzrlib
>> function that might create a transport.  This enables bzrlib to reuse
>> existing transports when possible, avoiding multiple concurrent
>> connections to the same remote server.
>>
>> If the remote server is accessed via ssh, this fixes a couple of
>> problems:
>>   * If the user does not have keys loaded into an ssh agent, the user
>>     may be prompted for a password multiple times.
>>   * If the user is using OpenSSH and the ControlMaster setting is set
>>     to auto, git-remote-bzr might hang.  This is because bzrlib closes
>>     the multiple ssh sessions in an undefined order and might try to
>>     close the master ssh session before the other sessions.  The
>>     master ssh process will not exit until the other sessions have
>>     exited, causing a deadlock.  (The ssh sessions are closed in an
>>     undefined order because bzrlib relies on the Python garbage
>>     collector to trigger ssh session termination.)
>
> I forgot to mention:  I didn't add a Signed-off-by line because there is
> no mention of a copyright license at the top of git-remote-bzr.

And why is that relevant? A signed-off-by line means you wrote the
code and you are fine with the patch being applied, or you are
responsible somehow.

-- 
Felipe Contreras
