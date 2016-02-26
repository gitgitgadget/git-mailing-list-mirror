From: Guilherme <guibufolo@gmail.com>
Subject: Fwd: git clone does not respect command line options
Date: Fri, 26 Feb 2016 12:17:49 +0530
Message-ID: <CAMDzUtxQPMty0Nncr7Yj3up6Zb6F-E0QudOMOZO_jG-Goq0YBg@mail.gmail.com>
References: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 07:48:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZCCg-0001v9-FK
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 07:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbcBZGsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 01:48:30 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:35641 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbcBZGs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 01:48:29 -0500
Received: by mail-vk0-f46.google.com with SMTP id e6so69338973vkh.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 22:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=4MyGcmUEf48QO2HgYjIW04Dp10v+rV3QdI3Dd4Sl52A=;
        b=ajKVug7tf9MpwJGTYe5EhFUuLgSfmAi10m1g5/npcgmAdUdxf21X0Lm+ZoIRaz48Q7
         ozZ+qESSnYJHnOsuGCVcWoqBTMDv2OaUjJL6FyKZLB8OhvOVpPEqLXWV90q05u1ffXy5
         l221C6m/DHCMYVLSX/eD8kc67pQ3s3cqXx0oHGuuQlv4gaADaJuZ19noDKgFFT4JTDeE
         b0PxgRTfO9+Had5O1S+JsYHJ8XlowciC+FYgYzuj9mkBMIHIJ2yubeycmHn1pf9BVySS
         A9cBbXchAXHppaimvhmy8qVnHZLD8ARzVVPjYe7Ow8WCtPHQn6mOWhxNlW4sbpgGvFLe
         r+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=4MyGcmUEf48QO2HgYjIW04Dp10v+rV3QdI3Dd4Sl52A=;
        b=WZawGFzrrQ6cmVVL500C09PWFHlHrAN0ZNzPTlTebAl+iTdTY22LcupKnEJG4NN1np
         jSC2yJcNUJDScGrxwFfCf1hiap15zKKNZughbmg6ny0xORQZ9jDSw+kFvkrtR26R7YmD
         pcZbh+Z+waT08CavVEeKDCuKssmexiWOiytVmwK1SxvziRT+ZIhNZxxH3iiz+2lAbWX0
         seudD+04dUKTJIvYNUHtdeByQnWlycN5Wz/jNHGshfhmwN1nswPRL6ICb+C212dkZZxD
         E2smwkB7UYOOKryWMOU8eg5gUF1Hit9QlK5Xi4he8xQX3s/aaaX9shWlM0LjPJH0t75u
         KsLw==
X-Gm-Message-State: AG10YOTPqVr1s7g9vCkNI61jTzjSdtL91TQMwpJT1ISb2CF8DoLxsRcr3rdAqbW1pJsY3HME9Fm3c2e125NIag==
X-Received: by 10.31.6.143 with SMTP id 137mr40536126vkg.133.1456469309046;
 Thu, 25 Feb 2016 22:48:29 -0800 (PST)
Received: by 10.31.162.145 with HTTP; Thu, 25 Feb 2016 22:47:49 -0800 (PST)
In-Reply-To: <CAMDzUtzoiJWzckTX818HJV=su0eEP35gsNDJ=+k_me08EDvxRg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287538>

Hi!

I'm trying to use git in an integration test and i'm having trouble
with configuration options.

On windows developer machines we use wincred as our credenital helper
and thus have it set in ~/.gitconfig

For the integration test that is no use as it will make testing
unauthorized logging in impossible.

Since there is no way of disabling configuration options on the
command line i tried setting it to store with a file I could delete.
So in front of every command we insert `-c credential.helper="store
--file=creds.txt"`. In the end the command line looks like:

git -c credential.helper="store --file=creds.txt" clone
http://admin:admin@oururl@20000/TestRepo.git

I see the file creds.txt being created containing only
http://admin:admin@oururl@20000/TestRepo.git but the credenital at the
same time appears in the windows credential store.

Can anybody else confirm this?

Thank you.
