From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [JGIT PATCH 03/15] Add IntList as a more efficient representation of List<Integer>
Date: Fri, 12 Dec 2008 16:50:32 +0100
Message-ID: <bd6139dc0812120750j19b4d56an24b9c52a3ca60f20@mail.gmail.com>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
	 <1229049981-14152-2-git-send-email-spearce@spearce.org>
	 <1229049981-14152-3-git-send-email-spearce@spearce.org>
	 <1229049981-14152-4-git-send-email-spearce@spearce.org>
	 <bd6139dc0812120243y2b1a3dddu4975162114280e17@mail.gmail.com>
	 <20081212151533.GM32487@spearce.org>
	 <bd6139dc0812120733o7c828532qbcd78c46a321fe6b@mail.gmail.com>
	 <20081212154115.GO32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 16:56:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBAMl-00058S-BY
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 16:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757444AbYLLPyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 10:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757314AbYLLPyS
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 10:54:18 -0500
Received: from mail-bw0-f13.google.com ([209.85.218.13]:42154 "EHLO
	mail-bw0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757408AbYLLPyR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 10:54:17 -0500
Received: by bwz6 with SMTP id 6so3596824bwz.13
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 07:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=1VTb90zn4bcCcy4cRRA4CxYMQlTNaPTLX/82EaH3Opg=;
        b=HqcgMY0P+JZcH8ZMqDe/RdDDfRvFMxbRw2zMrBtUkl38qZrPHSMIBbD9YwfJPhKDia
         0hax6H/wW3hpTyGxUayet9z3TYqYQENVt0MkUT0TKHv5ySPHu77ohGMw7fjOG9aJhf3N
         vAg8IfxxQcsg9FEhIrfxzu/BdtQqfH5GXRo5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=YBbBiMLilr44ZJUHuaW40Yohw8XPV1CrSKGoRu7ymYbVjibGYEB6zBKCfnNdcepG85
         hQH+6BvWLU5LWIqzFCjCZBl1gcJrYIeZBhcD3i1h/01I0oL9Beap7lyiclmpsGByEp2Y
         D3J2+LgsGiZDddBLa/M01TGQbVPy8VBDo4QPY=
Received: by 10.223.110.144 with SMTP id n16mr4313157fap.55.1229097032743;
        Fri, 12 Dec 2008 07:50:32 -0800 (PST)
Received: by 10.223.103.142 with HTTP; Fri, 12 Dec 2008 07:50:32 -0800 (PST)
In-Reply-To: <20081212154115.GO32487@spearce.org>
Content-Disposition: inline
X-Google-Sender-Auth: 464def918888bfc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102908>

On Fri, Dec 12, 2008 at 16:41, Shawn O. Pearce <spearce@spearce.org> wrote:
> If you'd like to send a patch to change it, I'll apply it.  But I
> don't think its worth my time to make this toString() more efficient.

I mainly mentioned it because it's in a Class meant to be more optimal
than what Java ships with, but I agree with your reasoning that this
toString is not part of what needs to be optimized.

> Other areas of JGit I do try to micro-optimize, because they are
> right smack in the middle of the critical paths.

Hehe, I very much agree with not optimizing prematurely, and if you do
optimize to go for it all the way.

> E.g. look at ObjectId.equals(byte[],int,byte[],int). I hand-unrolled
> the memcmp loop because the JIT on x86 does *soooo* much better
> when the code is spelled out:

<code snipped>

Kind of sad that you have to write this kind of code if you want good
performance, ah well, perhaps someday... (import java.lang.optimized
;) ).

> This block is in the critical path for any tree diff code, in
> particular for a "git log -- a/" sort of operation.  Its used
> to compare the SHA-1s from two different tree records to see if
> they differ.  Not unrolling this was a huge penalty.

I reckon that is done a lot :). Ashame the JRE can't do that kind of
optimization for you. e.g., if you do:
for(int i = 0; i < constant; i++) {
  some_code;
}

-- 
Cheers,

Sverre Rabbelier
