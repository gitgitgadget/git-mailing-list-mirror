From: Carlos Rica <jasampler@gmail.com>
Subject: Re: [PATCH] builtin-tag.c: remove global variable to use the callback 
	data of git-config.
Date: Wed, 18 Mar 2009 01:50:52 +0100
Message-ID: <1b46aba20903171750p5d63d94bq347db4ce06bda95b@mail.gmail.com>
References: <1237301031.10001.13.camel@equipo-loli>
	 <alpine.DEB.1.00.0903171646140.6393@intel-tinevez-2-302>
	 <1b46aba20903171057r4fb4697eo3b8abc62a45fe858@mail.gmail.com>
	 <alpine.DEB.1.00.0903172326250.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 01:59:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljk8G-00032t-Up
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 01:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbZCRA6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 20:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbZCRA6P
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 20:58:15 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:39208 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998AbZCRA6O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 20:58:14 -0400
Received: by bwz17 with SMTP id 17so316879bwz.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 17:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n3EU0TyFLakOZ/6RksNcvBu5iwr6gsRvObkJzAeLRzY=;
        b=IDqbLFiwdf6JESAtvR4nHmSTnydCPtnM7MQ6koav+vgB/W7IzIIx6ljTl2S8+P2g6I
         LSg6lW79HM9neLBDIB5Ph8og/cmAhTrwOA/PfX8BsMmuoFMDZu8mhulviX5i9spGKUL1
         H0cxJlkNLhIeJ6dzjVQwDpZeenYvwy6349aT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SaN6c3szf5HgQ+fuvW3+i3YPPw/S3PZW9cIWJbSf//8BU2ZeyCCanV3Qj/Y+sFRrYk
         2D9yq/svdX/+lgics/pTUHd9uNX2rXnp8t9shRn/UyjGo2NkXSMLKVjSRBqj+ZsmGSWb
         OLy9OSMb1EC2zSzCDXZbQghks7nQHLp72qe7w=
Received: by 10.223.103.207 with SMTP id l15mr582204fao.2.1237337452962; Tue, 
	17 Mar 2009 17:50:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0903172326250.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113547>

On Tue, Mar 17, 2009 at 11:27 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 17 Mar 2009, Carlos Rica wrote:
>
>> On Tue, Mar 17, 2009 at 4:47 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > Hi,
>> > On Tue, 17 Mar 2009, Carlos Rica wrote:
>> >> @@ -164,11 +162,10 @@ static int do_sign(struct strbuf *buffer)
>> >>       int len;
>> >>       int i, j;
>> >>
>> >> -     if (!*signingkey) {
>> >> -             if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
>> >> -                             sizeof(signingkey)) > sizeof(signingkey) - 1)
>> >> -                     return error("committer info too long.");
>> >> -             bracket = strchr(signingkey, '>');
>> >> +     if (!signingkey->buf[0]) {
>> >
>> > It is probably better to ask for !signingkey->len (think of trying to
>> > understand the code in 6 months from now).
>>
>> I was in doubt here. By avoiding the use of signingkey->len  I was
>> trying to say that you cannot rely in such field if we touch the
>> buffer directly, as it happens below:
>>
>>    bracket = strchr(signingkey->buf, '>');
>>    if (bracket)
>>       bracket[1] = '\0';
>
> Oh, I missed that.  It should read
>
>        if (bracket)
>                strbuf_setlen(signingkey, bracket + 1 - signingkey->buf);
>
> instead.

I agree! That's much better. Thanks Dscho and Junio.
Tell me if you need me to resend the patch with both changes.
