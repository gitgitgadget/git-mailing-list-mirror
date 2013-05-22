From: Chico Sokol <chico.sokol@gmail.com>
Subject: Re: Reading commit objects
Date: Wed, 22 May 2013 11:25:31 -0300
Message-ID: <CABx5MBSmCN=avRDCJ+RU8FoRDaGG=6uRfTdVR9m3A=SqpuKAjQ@mail.gmail.com>
References: <CABx5MBQ57-=MPamvV-peZUdD_KDLX+5cy9vD7CL7p_Vz9BkvTg@mail.gmail.com>
 <CAEBDL5XwrD8ZbRRSrM1iJGtcRgziH5bFVwRHzg9=_PYzaTfgAg@mail.gmail.com>
 <CABx5MBSnpZTthOHECqkbpdbFfkb4e_uSo-rh4owBc8B_oSKjJQ@mail.gmail.com> <CAJo=hJtqACW+CR5FkmDfwyK1Wg3Kcppy6DbW7P=On_qJyvsYvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Szakmeister <john@szakmeister.net>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 22 16:26:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf9zM-0004Ap-PO
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 16:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142Ab3EVOZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 10:25:54 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:57314 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab3EVOZw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 10:25:52 -0400
Received: by mail-ve0-f170.google.com with SMTP id 15so1476697vea.15
        for <git@vger.kernel.org>; Wed, 22 May 2013 07:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tWBSohfI+I+qwWbW5cadFYKOS4iKB7qSXAIoq1KVzm4=;
        b=TbSmHPGMdR55GwShWjsExgaLzJs26Z/d3SjXgY3f6r+qFojT2apgN76mtH/H5WTOnY
         9a1GnjJa/oR47blwDnf/nQQ98oC3ipi1cWB8n3hT1EdzykNnP3ZIa6RqUtggw2crNvW4
         LB18Vpmj7eD9ePjQikvRw2SMF7qzpqxqX1afa6leSSsPHdXGb0W6Ss4aRYMD+qWccsma
         96SH04QP/B9Noe9XRlgWwxyB910e68qe8RAcUFZWPJuTITvEVxAhQVD4RARYOMt6uCrc
         iI/g5alB67tFtx7gbMUlPoc9yG/3nYpt9MDOFBczxMAxUenqNg9GqxBg8Gej2TdYUSfW
         7V/A==
X-Received: by 10.220.192.3 with SMTP id do3mr2885485vcb.16.1369232751596;
 Wed, 22 May 2013 07:25:51 -0700 (PDT)
Received: by 10.220.80.10 with HTTP; Wed, 22 May 2013 07:25:31 -0700 (PDT)
In-Reply-To: <CAJo=hJtqACW+CR5FkmDfwyK1Wg3Kcppy6DbW7P=On_qJyvsYvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225162>

> Your code is broken. IOUtils is probably corrupting what you get back.
> After inflating the stream you should see the object type ("commit"),
> space, its length in bytes as a base 10 string, and then a NUL ('\0').
> Following that is the tree line, and parent(s) if any. I wonder if
> IOUtils discarded the remainder of the line after the NUL and did not
> consider the tree line.


Maybe you're right, Shawn. I've also tried the following code:

File dotGit = new File("objects/25/0f67ef017fcb97b5371a302526872cfcadad21");
InflaterInputStream inflaterInputStream = new InflaterInputStream(new
FileInputStream(dotGit));
ByteArrayOutputStream os = new ByteArrayOutputStream();
IOUtils.copyLarge(inflaterInputStream, os);
System.out.println(new String(os.toByteArray()));

But we got the same result, I'll try to read the bytes by myself
(without apache IOUtils). Is the contents of a unpacked object utf-8
encoded?
