From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] rev-list: Introduce --no-output to avoid /dev/null redirects
Date: Fri, 09 Nov 2007 00:58:00 -0800
Message-ID: <7vsl3fvlrb.fsf@gitster.siamese.dyndns.org>
References: <20071108080052.GB16690@spearce.org>
	<7vejezx4b2.fsf@gitster.siamese.dyndns.org>
	<20071109081204.GB2794@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 09:58:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqPhI-0000I5-Fh
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 09:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXKII6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 03:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbXKII6K
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 03:58:10 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47100 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbXKII6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 03:58:08 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 924B02F0;
	Fri,  9 Nov 2007 03:58:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 14B4E90C21;
	Fri,  9 Nov 2007 03:58:24 -0500 (EST)
In-Reply-To: <20071109081204.GB2794@steel.home> (Alex Riesen's message of
	"Fri, 9 Nov 2007 09:12:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64143>

Alex Riesen <raa.lkml@gmail.com> writes:

> Junio C Hamano, Fri, Nov 09, 2007 08:32:01 +0100:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> 
>> > @@ -640,7 +656,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>> >  		}
>> >  	}
>> >  
>> > -	traverse_commit_list(&revs, show_commit, show_object);
>> > +	traverse_commit_list(&revs,
>> > +		nooutput ? noshow_commit : show_commit,
>> > +		nooutput ? noshow_object : show_object);
>> >  
>> >  	return 0;
>> >  }
>> 
>> The function names noshow_xxx() looked a bit funny, but I do not
>> offhand have better alternatives to offer.
>
> "hide", "skip", "ignore"?

But look at what the functions do.  The original show_xxx() was
to print and then process.  Shawn splitted them into show_xxx()
and noshow_xxx(), leaft the printing part in the former, made
the former call the latter at the end, and moved the processing
to the latter.  So it is not any of the three words.
