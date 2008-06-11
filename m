From: "Ben Lynn" <benlynn@gmail.com>
Subject: Re: git bugs
Date: Tue, 10 Jun 2008 19:31:25 -0700
Message-ID: <832adb090806101931y754fa6b7nfcb58a9c34f0c582@mail.gmail.com>
References: <832adb090806100141n69c086a2v2f59fe94b2f4ead3@mail.gmail.com>
	 <alpine.LFD.1.10.0806101028040.3101@woody.linux-foundation.org>
	 <832adb090806101145w55729676ya7bcfb41b0413f59@mail.gmail.com>
	 <alpine.LFD.1.10.0806101249580.3101@woody.linux-foundation.org>
	 <832adb090806101609q17a21948nb5814c3b22bd832d@mail.gmail.com>
	 <7v1w34dfn3.fsf@gitster.siamese.dyndns.org>
	 <832adb090806101702l79aba80cvba1eaab029e9ecd5@mail.gmail.com>
	 <alpine.LFD.1.10.0806101834460.3101@woody.linux-foundation.org>
	 <832adb090806101904k5eba3bd6p277c955b1782afbe@mail.gmail.com>
	 <alpine.LFD.1.10.0806101909430.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 04:32:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6G8M-0007fD-FM
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 04:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbYFKCb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 22:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbYFKCb1
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 22:31:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:44763 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbYFKCb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 22:31:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1972468fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 19:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TROQAzdB7BNZhTF4K4toV52yUP/Hbo+R4MpxfqTtU4U=;
        b=m09W17m2t6fva5fHKx1EtGcKLZzj4pBVyJhMLKVfHFref/TnjvfBmgc3ZX5al4T/HG
         JcVJs/dIkhMDPHVAMdQ0F80ySBtL86G8epezCuCLmGzf7z7eiRFotWQ6Oe8hCXPotVjs
         9rUR8Rm7MbMp/RonJcJvzhbK64U3kGW/DJUBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=B+L11ySKd+XVVfEmfcH2xx/L8WFYPiHXmKNGssMZdatzVwAl8agMWmQOzYrrIugoWG
         m+XYs2b2BomrW0DllVoBRgKkf3ygan38baWrhK8f2CehDSEY4XZjboewvG3qi3diNkTB
         TNpwYT4nX8lX7DVCkdxOLafeSrI4RtXdBf4TY=
Received: by 10.86.4.2 with SMTP id 2mr6532260fgd.16.1213151485106;
        Tue, 10 Jun 2008 19:31:25 -0700 (PDT)
Received: by 10.86.79.17 with HTTP; Tue, 10 Jun 2008 19:31:25 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101909430.3101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84583>

Ah, I hadn't seen that. Yes, it is better to use the first write as
the timestamp. Would this catch everything? If the filesystem clock is
monotonically increasing and consistent then with this setup, you can
touch files even as they are being indexed? (Disregarding nonsense
like changing sizes by 2^32.)

Just realized I should have paid more attention to Junio's first reply
to me. My eye had skipped over the paragraph about clock skew, and
this caused some confusion. Sorry about all my extra emails!

-Ben

On Tue, Jun 10, 2008 at 7:12 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 10 Jun 2008, Ben Lynn wrote:
>>
>> Sorry, but if we're assuming no one is touching the files while we're
>> updating the index (including writing it to disk), why does it matter
>> whether we use the time of first or last write? In fact, if a index
>> write takes a long time, using the last write time as the mtime would
>> be beneficial for the race condition stuff.
>
> Oh, if you assume nobody is touching the files as the index is created,
> none of this matters.
>
> So if *that* was your only race worry, then git should already be
> perfectly fine.
>
> The issue with the timestamp of the index only happens if somebody ends up
> modifying the files that are being indexed _as_ they are indexed. Quite
> frankly, git will notice that too in just about all possible cases, but if
> the size stays the same and the modification time ends up still being
> smaller than the final index mtime (because writing the index took so
> long!), then you might miss some modifications that would otherwise be
> noticed.
>
>                Linus
>
