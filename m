From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 14:18:36 -0600
Message-ID: <53A99181-32FC-402F-8ADD-49076131B891@gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com> <7vliaxwa9p.fsf@alter.siamese.dyndns.org> <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com> <201302101226.12646.mfick@codeaurora.org>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:19:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4dMf-000443-Bw
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 21:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761149Ab3BJUSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 15:18:42 -0500
Received: from mail-ob0-f170.google.com ([209.85.214.170]:37071 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761108Ab3BJUSm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2013 15:18:42 -0500
Received: by mail-ob0-f170.google.com with SMTP id wc20so5531399obb.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 12:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:x-mailer:from:subject:date
         :to;
        bh=SOtg6pVN0Z2TyIIDP0qEgjD9SyZw6nc6x7V6qUO0a94=;
        b=WFlLhkfOK2ayqjX/MM/B1m8WQuAKAAx/BFjhF1GpDCH9Aemmzuv1n4G4XcUrUayXkf
         13/SOnqiDP1eJXq64u1d91dZXyN3StY2aKqwc9Nj+k4MOrxtFgBQWFe3xTqy1Wiou0+0
         NKBjY7q+tVxwOk1QMGCXGOVYVS8w4R1wkpCn03PmGVR4HMgFSYPPkGrgw0L+J5lw4I8S
         dU9zNBw9ye0ibf4YY1lK3Gdyf3BAmn5SjQv5oUwCBhPn4k73vL26uH7qjUO6sw/djAO3
         EfZYHOmTpTD9EnNNgKBLmi8OECsPmQeqRfMW+IWkAndxGLIJqCvkSvHNQ+aPuh4tSDct
         b3YQ==
X-Received: by 10.60.27.169 with SMTP id u9mr8951910oeg.138.1360527521638;
        Sun, 10 Feb 2013 12:18:41 -0800 (PST)
Received: from [192.168.1.72] (108-90-21-196.lightspeed.cicril.sbcglobal.net. [108.90.21.196])
        by mx.google.com with ESMTPS id el2sm46347286obc.9.2013.02.10.12.18.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 12:18:39 -0800 (PST)
In-Reply-To: <201302101226.12646.mfick@codeaurora.org>
X-Mailer: iPhone Mail (10B141)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215931>



On Feb 10, 2013, at 1:26 PM, Martin Fick <mfick@codeaurora.org> wrote:

> On Sunday, February 10, 2013 12:03:00 pm Robert Zeh wrote:
>> On Sat, Feb 9, 2013 at 1:35 PM, Junio C Hamano
> <gitster@pobox.com> wrote:
>>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>>> This is much better than Junio's suggestion to study
>>>> possible implementations on all platforms and
>>>> designing a generic daemon/ communication channel. 
>>>> That's no weekend project.
>>> 
>>> It appears that you misunderstood what I wrote.  That
>>> was not "here is a design; I want it in my system.  Go
>>> implemment it".
>>> 
>>> It was "If somebody wants to discuss it but does not
>>> know where to begin, doing a small experiment like
>>> this and reporting how well it worked here may be one
>>> way to do so.", nothing more.
>> 
>> What if instead of communicating over a socket, the
>> daemon dumped a file containing all of the lstat
>> information after git wrote a file? By definition the
>> daemon should know about file writes.
> 
> But git doesn't, how will it know when the file is written?
> Will it use inotify, or poll (kind of defeats the point)?
> 
> -Martin

I was thinking it would loop on calls to stat for the file with a timeout; this is no different than what we would want to do over a socket in that we would need timeouts for network reads.  But we would only be calling stat on one file, instead of the entire repo. 

I think we can set things up so the file read is atomic, which means we can ignore the case of a daemon crashing midway through a conversation. 

Robert
