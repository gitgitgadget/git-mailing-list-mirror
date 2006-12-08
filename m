X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Fri, 8 Dec 2006 08:48:09 +0100
Message-ID: <81b0412b0612072348q13faaab0s9ba7a235f7fd64dc@mail.gmail.com>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
	 <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net>
	 <20061207221503.GA4990@steel.home>
	 <7vr6vbqqzh.fsf@assigned-by-dhcp.cox.net>
	 <20061208052705.GA4318@steel.home>
	 <7vzm9ynahc.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0612072327x77477584jb9131b26b0854f2@mail.gmail.com>
	 <7vhcw6n8iz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 07:48:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rbvhAooDSVEFe2jScRcBvd0PJwJpdCQkmkYk0q4e1NIP490bgZo4XQGs726tKoIuhfmLi6LLNc2oKHFbPKT5lBa3yEEF97Y/Smg/ZTziSiiHko0h5cVLDcIwUkN8PioFWKbaUYxbeUQR7aEWnkxnmt6dg/V37s4IotLX1bcEWZA=
In-Reply-To: <7vhcw6n8iz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33670>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsaSu-0000rT-DI for gcvg-git@gmane.org; Fri, 08 Dec
 2006 08:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425093AbWLHHsM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 02:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425097AbWLHHsM
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 02:48:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:13453 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1425093AbWLHHsL (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 02:48:11 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1069796nfa for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 23:48:10 -0800 (PST)
Received: by 10.78.158.11 with SMTP id g11mr1705434hue.1165564089873; Thu, 07
 Dec 2006 23:48:09 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Thu, 7 Dec 2006 23:48:09 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/8/06, Junio C Hamano <junkio@cox.net> wrote:
> >> The current code for "diff-index --cached" reads the whole tree
> >> into the index as stage #1 entries (diff-lib.c::run_diff_index),
> >> and then compares stage #0 (from the original index contents)
> >> and stage #1 (the tree parameter from the command line).  Even
> >> if you stop at the first mismatch, you would already have paid
> >> the overhead to open and read all tree objects before even
> >> starting the comparison.
> >
> > But I don't have to pay for the overhead of comparing all
> > entries, if I can stop at first mismatch and exit with non-0.
>
> Bench it if you doubt me.

I don't question that the overhead of comparing is very much
unnoticable. It just that it surely isn't zero, and it will grow with
the size of repo (linearly, right?)... And I am sure that this
repo will _only_ grow (typical corporate project).

> I'd bet that the time spent in comparison between stages inside
> index (and remember, you are not generating textual diff, only
> comparing the SHA-1) is dwarfed by the overhead of populating
> the stage #1 of the index with what is read from all the tree
> objects.

I already understood that. I just haven't found yet what can I do
