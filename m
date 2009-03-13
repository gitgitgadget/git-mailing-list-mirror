From: Daniel Cheng <j16sdiz+freenet@gmail.com>
Subject: Re: [PATCH JGIT] Allow writeObject() write to OutputStream
Date: Fri, 13 Mar 2009 23:47:48 +0800
Message-ID: <ff6a9c820903130847s5ade3df6p31089cbd4b688966@mail.gmail.com>
References: <1236844931-12807-1-git-send-email-j16sdiz+freenet@gmail.com>
	 <20090313150806.GE22920@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 16:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li9dV-0003To-80
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 16:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758949AbZCMPrx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 11:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758944AbZCMPrw
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 11:47:52 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:62348 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758994AbZCMPru convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 11:47:50 -0400
Received: by wf-out-1314.google.com with SMTP id 28so502418wfa.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 08:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=i3CD5tbhpIPdPsysG8MV9FhRzDDvV9flMWKCVETHZoI=;
        b=XcSvY9pj88egdR2xrcZj8ixg2swXutNmj5/97ZJ306wql26yDcHj8xIsKg9Tr57FCr
         t/p547VxRBZvaGtwUFtzf4nDM5OlrV8Hq5o4HP9Z2tBBEhx5HKN7vsOzcL59qTmqF8TQ
         ebMzCYIt1ukeC0WNqHJb59bdw1ohLkq7bNPmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=cxu7DUza1jxNx2TiNRAOuuXI8HpuO3iY1oqenOehnLjcT6L6XaN9aXQZY5s2+zqoLZ
         Ae0FjtoJ1gRfdIkPwQKCcZpouNzwzYiCDr4GCs4BlLVJy7lb3GrDqiyAtDi20lkJGdqS
         6G/CRW/t58yiCvK6eGkJWAm/bTh2wQzQVC2rQ=
Received: by 10.114.137.2 with SMTP id k2mr984149wad.130.1236959268313; Fri, 
	13 Mar 2009 08:47:48 -0700 (PDT)
In-Reply-To: <20090313150806.GE22920@spearce.org>
X-Google-Sender-Auth: 3f8ebd7a837c5502
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113201>

On Fri, Mar 13, 2009 at 11:08 PM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com> wrote:
>>
>> This patch make factor out the object writing code in ObjectWriter,
>> allow it to write to any OutputStream.
>> Subclass class may then override
>> =A0 writeObject(final int type, long len, InputStream is, boolean st=
ore)
>> to make it write to alternative locations.
>>
>> There are some discussion on devl@freenetproject.org to use raw
>> (uncompressed) object to freenet. This patch allow the testing.
>
> Ok, I understand the code as-is, but I'm not sure I understand the
> reasoning for the change, or where you are trying to go with it.

In freenet (and most content-addressable network), file can be dropped
out when unused.
We need some method to "heal" the lost data.
The easiest way is to do this is re-insert the very same file we used
originally.

Pack files may change on different compression parameter, object order,=
 etc.
It need some tricks to get the original file.
Loose object are immutable, so it is easier to use loose objects.

Nothing have finalized yet, we are just evaluating different approaches=
=2E

I know loose object are always larger, and have very large number of th=
em.
So it may backfire ....

> Are you guys talking about making every object a loose object on
> freenet, and avoiding pack files? =A0Or making a form of JGit that
> access a Repository directly stored on freenode?
>
> I ask because there's some folks starting to talk about putting JGit
> onto a distributed hash table sort of system like Hadoop HBase,
> to allow the underlying storage to scale efficiently for really
> big hosting sites. =A0I would rather see a pooling of effort here
> than folks going in different directions.
>
> --
> Shawn.
>
