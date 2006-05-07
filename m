From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unresolved issues #2
Date: Sun, 7 May 2006 13:31:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605071330210.22231@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net> <7v4q065hq0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0605041627310.6713@iabervon.org> <Pine.LNX.4.64.0605041715500.3611@g5.osdl.org>
 <7vhd43vgnm.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605060821430.16343@g5.osdl.org>
 <BAYC1-PASMTP10F63ADF30C26A29D070C5AEAA0@CEZ.ICE> <Pine.LNX.4.64.0605060923050.16343@g5.osdl.org>
 <BAYC1-PASMTP0824AA77198F95FE28B79DAEAA0@CEZ.ICE> <Pine.LNX.4.64.0605061008340.16343@g5.osdl.org>
 <7vvesirh0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0605062332420.6423@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7xekwbs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 07 13:32:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FchUf-0003U7-I2
	for gcvg-git@gmane.org; Sun, 07 May 2006 13:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWEGLbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 07:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWEGLbz
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 07:31:55 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8332 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932127AbWEGLby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 May 2006 07:31:54 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 28146205F;
	Sun,  7 May 2006 13:31:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 1CDFC205C;
	Sun,  7 May 2006 13:31:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 091FB1EC8;
	Sun,  7 May 2006 13:31:53 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7xekwbs.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19699>

Hi,

On Sun, 7 May 2006, Junio C Hamano wrote:

> [...] Probably a reasonable convention would be to define the config 
> file format to be something like this:
> 
>         <comment that applies to the section>
>         [section]
>                 <comment that applies to the variable stands on
> 		 its own before the variable>
>                 variable [= value] <comment that applies to the
>         			    fact the variable is set to
>                                     this particular value starts
> 				    on the same line as the
>                                     "variable = value" thing>
> 
>  - when a variable is reset to another value, remove the
>    "value comment";
>  - when a variable disappears, remove "variable comment";
>  - when a section disappears, remove "section comment";
>  - otherwise leave the comment intact.
> 
> Then we could tell the user the rule is like above, and tell
> them to structure the file with comments that way, if they ever
> want to edit the file by hand.
> 
> Now if we wanted to do something like the above, I suspect that
> it would be easier and less error prone to first scan the config
> file, note what appears where, and do the processing in-core,
> and then write the results out, perhaps using data structures
> like these:
> 
>         struct config_section {
>             char *pre_comment;
>             char *name; /* e.g. "core" */
>             struct config_section *next; /* next section */
>             struct config_var *vars; /* pointer to the first one */
>         };
>         struct config_var {
>             char *pre_comment;
>             char *name;
>             char *value; /* "existence" bool may have NULL,
>                           * otherwise probably a string "= value"
>                           */
>             char *value_comment;
>             struct config_var *next; /* pointer to the next one
>                                       * in the section
>                                       */
>         };
> 
> Obviously, data structures like these would make it even easier
> if we decide we do _not_ care about comments (we would just lose
> x_comment fields, parse the thing and write the resulting list
> out).

Sounds very reasonable.

Ciao,
Dscho
