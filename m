From: "Tilo Schwarz" <tilo@tilo-schwarz.de>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 21 Feb 2009 18:35:36 +0100
Message-ID: <op.uppptmu7a8ed4e@dellschleppa>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
 <op.uo9hiqqqa8ed4e@dellschleppa>
 <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
 <op.upgqjej6a8ed4e@dellschleppa>
 <2c6b72b30902201535q2466b8fbtce746a5263ebf320@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jonas Fonseca" <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 18:37:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lavms-0004Xq-F7
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 18:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbZBURfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 12:35:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbZBURfn
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 12:35:43 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:64098 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbZBURfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 12:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1235237739; l=1993;
	s=domk; d=tilo-schwarz.de;
	h=In-Reply-To:Content-Transfer-Encoding:References:MIME-Version:
	Content-Type:Cc:From:Subject:To:Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=VCYaOwGZ6HAeq8fjusJWRGvyfl8XffttD89/5g/K/Y0=;
	b=Ye25DBo2zqx6VmDBKLLCgn7Lift+efosk/u5enMr9ByXEAk+HEBR5fESZPMBsNBodFD
	XS8Tn5iI3Z1jE+8Gohs4DbukRLFB1vtPRXyqDUd30nPsppOXuZvXzL0Cje1i/DLdVcFt1
	pBl/BlsacnhGa/YryWGzyrDsp7qQe4K86Hc=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlsR31cxKBZU=
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CE37E.dip.t-dialin.net [84.156.227.126])
	by post.strato.de (fruni mo54) (RZmta 18.21)
	with ESMTP id N06bb9l1LH1WHe ; Sat, 21 Feb 2009 18:35:37 +0100 (MET)
In-Reply-To: <2c6b72b30902201535q2466b8fbtce746a5263ebf320@mail.gmail.com>
User-Agent: Opera Mail/9.63 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110969>

On Sat, 21 Feb 2009 00:35:59 +0100, Jonas Fonseca  
<jonas.fonseca@gmail.com> wrote:

[...]
> OK, I have added the begining structure for a branch view, bound to
> 'H' by default. It does not support any actions besides refreshing and
> viewing the branch history. So there is still some work to achieve the
> easy access to branch commands.

That's really nice!

>> BTW, is the git list the right list to discuss bugs / patches for tig?
>
> Yes please.

Ok, here we go ;-).

I can trigger a SIGSEGV in da8b99da8f4dc5512c23154ec6c0aa7d3c313555
like this, using the tig repo itself:

- Start ./tig --all
- Enter the new branch view pressing 'H'
- Add a new branch foo using git checkout -b foo on some
   console or in tig using ':checkout -b foo'
- Press F5 in the branch view to reload
- Move cursor on the new branch foo
- Press ENTER

Then I get a SIGSEGV in line

6150                            if (ref->head)

(gdb) print *ref
Cannot access memory at address 0x2d676974

#0  0x08056427 in main_draw (view=0x8060500, line=0x9b61638, lineno=0) at  
tig.c:6150
#1  0x0804d19d in draw_view_line (view=0x8060500, lineno=0) at tig.c:2111
#2  0x0804d269 in redraw_view_from (view=0x8060500, lineno=0) at tig.c:2141
#3  0x0804d2bf in redraw_view (view=0x8060500) at tig.c:2152
#4  0x0804f70b in open_view (prev=0x8062fa8, request=REQ_VIEW_MAIN,  
flags=OPEN_SPLIT) at tig.c:3055
#5  0x08053241 in branch_request (view=0x8062fa8, request=REQ_ENTER,  
line=0x9b6b038) at tig.c:4783
#6  0x0804f9df in view_driver (view=0x8062fa8, request=REQ_ENTER) at  
tig.c:3142
#7  0x080594a3 in main (argc=Cannot access memory at address 0x3

I tried to track this down, but was not successful yet (having seen tig.c  
the first time today). I looked in get_refs and read_ref, but couldn't  
nail it down up to now. It feels, as if the refresh does find and update  
the new branch foo, but the corresponding commit->refs are not properly  
updated (just guessing).

Best regards & thank you for tig!

     Tilo
