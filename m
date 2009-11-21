From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Sat, 21 Nov 2009 13:47:17 -0800
Message-ID: <A2458D5A-DBAD-4F74-B166-92BEEB162418@gmail.com>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com> <19205.2531.205062.980468@cargo.ozlabs.ibm.com> <20091119193913.GA25410@gmail.com> <19205.50406.91209.309984@cargo.ozlabs.ibm.com> <7vhbsp7htq.fsf@alter.siamese.dyndns.org> <20091120185522.GC56351@gmail.com> <7veinsx6lj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, "peff@peff.net" <peff@peff.net>,
	"sam@vilain.net" <sam@vilain.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"markus.heidelberg@web.de" <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 22:47:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBxno-0008TK-MD
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 22:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791AbZKUVrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 16:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756699AbZKUVrU
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 16:47:20 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:37742 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbZKUVrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 16:47:19 -0500
Received: by gxk26 with SMTP id 26so3866128gxk.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 13:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:x-mailer
         :mime-version:subject:date:cc;
        bh=ABJrvZN/IQUx9sd04RLnhfMY8rOd3w4BO3JSu71kLyI=;
        b=XuodcXAD4AetR6CYUIvjTgx4if+vxzAEa9vPnoeGudPui5xILavnjTweI4yMmIyjFi
         EhkCO9++9nDIAuS/T6KPB6A8m8lJzQGul+VQq8X2CwsfOeuMwbes/1urQJesiMhHi32B
         hYH5EnCbk/E7C0cWsOg8UpOQ0r8FJ2DFQuQ80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=YLD7C/qw8jll29hm3WethHa64FF9eYwDc3/QJfxYEbu1trjbdcqNoy1If06MEB8RUz
         4YF/vxrnUEF1Sv3bqiopRu2nUyYn98HadAStbQrpvUZAQrOjToNv2zYkswiCp5nvTVq+
         Lks0yGWoFhTHt+ZXWXPrBoe5bDV480G+gksjc=
Received: by 10.150.110.23 with SMTP id i23mr5250310ybc.345.1258840044990;
        Sat, 21 Nov 2009 13:47:24 -0800 (PST)
Received: from ?192.168.1.3? (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 6sm992644ywc.9.2009.11.21.13.47.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Nov 2009 13:47:23 -0800 (PST)
In-Reply-To: <7veinsx6lj.fsf@alter.siamese.dyndns.org>
X-Mailer: iPhone Mail (7D11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133414>

On Nov 20, 2009, at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:

> I do not read Tcl very well but I am guessing that in gitk you specify
>>>
>>
> what tool to run (e.g. "frobanodiff -z"), gitk feeds you two temporary
> files on the filesystem to compare (e.g. "frobanodiff -z $tmp1  
> $tmp2"),
> and your command line is responsible for giving satisfying diff  
> experience
> to the end user.
>
> I see three possible approaches:
>
> * Teach "git-difftool" a mode to compare two arbitrary files on the
>   filesytem, and set that as "External Diff" command that takes the
>   filenames as extra two parameters, just like any other "External  
> Diff"
>   programs given to gitk does.  This is the least palatable, as it  
> won't
>   solve the read-only repository issue at all (it only allows you the
>   logic to choose the configured difftool backend program).
>
> * Instead of disabling the traditional "External Diff" and taking it  
> over
>   like your patch did, add a new codepath for "Difftool" that feeds  
> the
>   commit IDs and paths the way git-difftool expects.  The user can use
>   both, and the issue of read-only repository is solved when  
> "Difftool"
>   is used (but not "External Diff").
>
> * Take over "External Diff" codepath exactly like your patch did, but
>   teach "git-difftool" a new command line option to name an  
> unconfigured
>   external program that takes two filenames.  When "External Diff"
>   program is *not* configured in gitk, the command line to invoke
>   difftool would be exactly as in your patch, i.e. "difftool --no- 
> prompt
>   $from $to -- $path".  Otherwise, when gitk is configured to use an
>   external program, e.g. "frobanodiff -z", for "External Diff", you  
> pass
>   that command line to "git-difftool" via that new option, e.g.
>
>     difftool --no-prompt --extcmd="frobanodiff -z" $from $to -- $path
>
>   Then difftool is responsible for preparing the two necessary  
> temporary
>   files out of the given information ($from/$to/$path) and feeding  
> them
>   to "frobanodiff -z" command line.
>
>   Maybe such --extcmd support already exists in difftool, in which  
> case
>   my earlier suspicion that difftool is not as flexible would be  
> false.

Sounds good.  Adding --extcmd should be nice and straightforward.   
Markus mentioned the need for a diff.guitool variable that would be  
tested for in the gitk case so it sounds like having a --gui option to  
let difftool know to do that should then cover all the bases.

It's looking like we'll have ourselves a small difftool patch series  
soon.  Thanks all,

-- 
         David 
  
