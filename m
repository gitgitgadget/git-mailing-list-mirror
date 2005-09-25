From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [ANNOUNCE qgit-0.95]
Date: Sat, 24 Sep 2005 22:52:59 -0700 (PDT)
Message-ID: <20050925055259.50066.qmail@web26302.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 07:53:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJPRi-0001iH-HG
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 07:53:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbVIYFxD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 01:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVIYFxD
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 01:53:03 -0400
Received: from web26302.mail.ukl.yahoo.com ([217.146.176.13]:7317 "HELO
	web26302.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751106AbVIYFxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 01:53:01 -0400
Received: (qmail 50068 invoked by uid 60001); 25 Sep 2005 05:52:59 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uiuKuMPsjX8BHcbpCrWbEaH+GbtuJIr4CXhATEnAZTO5T0csNqnUb/m7cnLxLnJIG5KzFFCh7IczHVhm1pk1hUXNNDMCsRkF+MDwHHJi08E3upq27690NwBmnlteZAckra8vwJUCActKtWcIsQVzYd4aM4X4WuUHQffzh/kYBh8=  ;
Received: from [151.38.74.126] by web26302.mail.ukl.yahoo.com via HTTP; Sat, 24 Sep 2005 22:52:59 PDT
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9257>

Petr Baudis wrote:

>
>Yes, it is several times faster than gitk, good work. Had to do this in
>order to be able to compile it with gcc-3.3.6, though (it complained
>about goto'ing after initialization of nc - that's bogus since there's
>the return, but...):


thanks, applied.

>
>Besides that, this is what I don't like about qgit:
>
>* It'd be nice to be able to choose to see all commits in the initial
>dialog by single click (I know about --all). Perhaps a radio buttons
>choosing between all and selected? Also, you might add the "diff against
>working copy" option to that dialog as well.

Yes.

>
>* The graph column is too narrow. It should be auto-sized so that the
>graph fits in, or at least there should be some clear indication that
>the graph does not fit to the column at the given point. This confused
>me a lot at first.

Auto fit the column width to the graph can be not always the best choice, see
0572e3da3ff5c3744b2f606ecf296d5f89a4bbdf (aka Linux v2.6.13-rc7) commit to see what I mean.

But an inidcation that the graph column is resizable is a good thing.

>
>* Could you make the grey background for odd commits span to the whole
>line, including the commit graph?
>

Yes, I am not sure of the results, there are already a lot of colors in the graphs, but I will
check.


>* The commit time is relative to now, which makes no sense to me. Also,
>it is in the second column instead of the last one like in gitk, which
>seems better to me. At least, the column is too narrow and then it
>blends together with the commit title.
>

I took the layout from gitweb where the order is -relative time - author - short log.
But this is the second time someone complains about time column so I will
send to last column: graph - shortlog - author - time


>* In the filter radio buttons groups, only first few letters of the
>labels are visible, and apparently no tooltips.

Yes. I will choose the tooltips way to save space, that line its already too long, this is
the reason I try to avoid adding buttons.

> Same problem in the
>settings dialog, most of the options have the labels cut around 2/3, and
>the window is non-resizable on top of that - why? I hate non-resizable
>windows, especially because they are usually too small. :-)
>

This is strange, I have resizable setting window and no cutted labels.......
This is for sure a bug but I can't reproduce on my box.

>* Single-clicking at a commit produces a significantly slower response
>than in gitk, where I see the difflist and stuff nearly instantly - it
>takes several hundreds of ms in qgit. That's quite annoying.
>

Please, is flag edit->settings->general->'load file names in background' set?


>* Getting to the diff view was non-obvious for me. It'd be nice to have
>some [diff] button as well somewhere. Or you could also show the diff in
>the bottom part of screen in the commit view, I think gitk solved this
>nicely.

I have tought a lot how to pass to the user the information that to see a diff you have to 
double click on the commit:

1) Adding a button with a 'double click' tooltip? --> use space forever for a one time
    information (once you know you can double click the button is useless, the space not).

2) Adding a menu entry with a tool tip? can be.

3) Add a tool tip directly on the commit line: can became annoying really soon.

4) Show always diff in commit info window? can be time consuming for merges (gitk doesn't shows
merges diff) and the space is limited or you need to resize forth and then back the commit info
window. Perpahs it's only me, but I need the whole screen to go deep in a diff when I really need
to understand the change.

In any case you are right, something has to be made.

>
>* Clicking on the file was supposed to bring some annotated view, but if
>it is so, it should write "Annotate" in the window title, and should
>indicate that it is computing it on the background (and is really slow
>in that, or I don't know, but always only single revision was shown
>there). It is unclear what the "pin file" checkbox is supposed to mean,
>and the whole dialog is just very confusing. :-)
>

Yes annotate can be slow with linux tree with some vip files ;-)

Please try with a small project or with a seldom
touched file: annotation should appear left aligned.

An example can be file daemon.c in git archive, you can reach 
from commit f8ff0c0641a14770a2214fffbd4271b1ea3a0d61

When you browse the file history list on top, the corresponding main view  
commit changes as does the file revision content: "pin file" checkbox simply avoids 
the file viewer content to change, only main view is updated.

This can be useful when you double click on the left align annotation number to jump to commit,
preserving the file view.


>* The lane information might be available as a tooltip in addition to
>right-clicking on it - that wouldn't occur to me.
>

Yes...now I see its also a little bit broken....bad luck ;-)


>* Why is the Edit menu aligned to the right?
>

Is it? really? I cannot reproduce, Its the only menu without shortcuts, but 
is correctly aligned here.

>* Well - I don't like the line graphics and prefer gitk's. This is
>perhaps a matter of taste, though. I find the graphics to be too tiny,
>thin and not so clear as gitk's, which makes it harder to see the commit
>flow. I also like diagonal lines more than angles, but that might be
>just because I'm used to them.
>

Diagonal line could be nicer but doesn't leave you play some tricks to greatly speed up
graph drawing. I really like those tricks ;-)

Then when the things get tough, with a lot of lines, the more 'regular' and geometrical
layout of qgit could help...but this is just a matter of taste.

>
>
>Nice work otherwise. :-)
>

Thanks for your very good feedback.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
