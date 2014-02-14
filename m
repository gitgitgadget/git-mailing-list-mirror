From: Stefan Zager <szager@google.com>
Subject: Re: Make the git codebase thread-safe
Date: Fri, 14 Feb 2014 13:49:34 -0800
Message-ID: <CAHOQ7J9QFWAY+12RSwgp3a6VwSOWnwRsP=R8Tf2JA2yG+Ay84Q@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
	<loom.20140213T193220-631@post.gmane.org>
	<52FD4C84.7060209@gmail.com>
	<CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
	<CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
	<52FE68C9.3060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Zachary Turner <zturner@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 22:49:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEQdi-00053j-1f
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 22:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbaBNVth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 16:49:37 -0500
Received: from mail-oa0-f42.google.com ([209.85.219.42]:53749 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbaBNVtf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 16:49:35 -0500
Received: by mail-oa0-f42.google.com with SMTP id i7so15192997oag.15
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hgOfveNnW7cU7QBhFspsWHYDJAmFZb2LO8+N+4HFMik=;
        b=jXuJHGdHSfglnFgEXRnUV3lVRgvxonnV6NwMwkP9TnQX4fQo3B3dyjjzaM+xVSHTNo
         coUWaqh+ljvVAlZ373eQDwEv31CS0bs3Yo2WDIRu3v+rd9AWk4zaVqGVr/kNlwDpDDn/
         a4smeQh5weWtot39D0kLmvEIpluwWLRo2GDEZcoe1u+ahVhsxbQW0xsyX8RVAIKyok6J
         g5e9e5aWLo6t8IbIQ/YDHlbHnY/hkk+FI+xmF/PNAo0R99RkV9iEkdq7F0G7EKGXDQjr
         e0x7X8rbO7xFb7LjkGiodaWHwAjX44LnVHARMgwcHs/ZhXjVmmA3X9bDSUgemDhaCEOT
         uYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hgOfveNnW7cU7QBhFspsWHYDJAmFZb2LO8+N+4HFMik=;
        b=SbUiEL17xTk/zqCppdF0RL6WYY/c4MIzNwprZlujOWVat52/cL3wBM95nd1SwgANXc
         fSZ/WHDE4iu+Uz7NbXHGMWJvMmdtUQ5Jh6RIdzSN+vJQWHXBNEAVSdgQRr5sui9YIgdh
         kNybouFCxQ9ZDP5QmsQ3pAzN//t9AMdjormDWUTqoHgqguYGFWEdjVvA1SLydS2mMWrz
         q9QgANNGu/gYpA0M7DmhKyGcNikp6ZhQZY+gKRUL5r2+MiSopb1xRapLILN3xRSXKCLj
         NF6WsO3TN0XIWGmxAZGNFAMdKk25fFYvKo8W3kCar6fxlB+Jmf1BOpKFpoFHxpqTAW+Q
         YJWA==
X-Gm-Message-State: ALoCoQlQva0fAU6e5Sw6mFhMw+kMD8lDLcE48ZJIhvmaiIXScBBZsEhunAsI3B56fZHL/PwFWiiT8ik2RyZzuxEPWM8EEfgmVM4ibNO80sdofQUyIO5HRHzA1TxgGSbe4anEGyncGLBvANMZ6+MxsqtrUCXgNtHKCl0A9hpBLthNeA8DSWwxlai3Ecu+ZFAxN1CCI7EkB6ta
X-Received: by 10.60.228.135 with SMTP id si7mr8564386oec.4.1392414575073;
 Fri, 14 Feb 2014 13:49:35 -0800 (PST)
Received: by 10.182.233.201 with HTTP; Fri, 14 Feb 2014 13:49:34 -0800 (PST)
In-Reply-To: <52FE68C9.3060403@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242151>

On Fri, Feb 14, 2014 at 11:04 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
>
> Damn...you're right, multi-threaded git-index-pack works fine, but some tests fail badly. Mixed reads would have to be from git_mmap, which is the only other caller of pread().

msysgit used git_mmap() as defined in compat/win32mmap.c, which does
not use pread.

Stefan
