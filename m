From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: [PATCH v4 1/4] t6006 (rev-list-format): don't hardcode SHA-1 in
 expected outputs
Date: Fri, 25 Jan 2013 15:06:20 +0400
Message-ID: <20130125150620.3b9dc9c3@ashu.dyn1.rarus.ru>
References: <cover.1359018188.git.Alex.Crezoff@gmail.com>
	<cee3610fde1626c2854eb5b821529ab22a06e4bf.1359018188.git.Alex.Crezoff@gmail.com>
	<7v38xqba04.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 12:06:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyh7Y-0002BE-Rx
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 12:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab3AYLG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 06:06:28 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:49561 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917Ab3AYLGY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 06:06:24 -0500
Received: by mail-lb0-f178.google.com with SMTP id n1so497616lba.9
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 03:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=wiagGUYfL+HncGmTrhs2GwE/rNyuw97vs42YfYnIQTI=;
        b=uC6PXj7TUNFM3lC491I7/JSwMTtMHrG+3siBbE3wta2Gt61Xhv0RgdUlotE/RgwW3E
         SJbukczijjm2yPs0mLhT6wKjLBayvHHRf76F9NaPk4VoWhrISwn5+Hd4SNPNxkCbDFMu
         1myZeyMAYBxg6WeHo1AN3xUoSSI47Bjey9kxC8MzT8G5Pa4Pu4HAniDNoOghwfyDMrDi
         loE0nnPnrQ7lLJflQO5mrwSFLTZL00RGHZRU3aCKyCRobeQ8ztqY+/RkzF94yHUrKY6e
         Uv9v4CxWFGUKiF6OcLOZSoTN3U0/V9VD0Ug86M5CbnRlCNkb1QFRTeZjFCprEBMU8642
         VRoA==
X-Received: by 10.152.122.133 with SMTP id ls5mr4876790lab.9.1359111982882;
        Fri, 25 Jan 2013 03:06:22 -0800 (PST)
Received: from ashu.dyn1.rarus.ru ([85.21.218.130])
        by mx.google.com with ESMTPS id a5sm395883lbl.1.2013.01.25.03.06.22
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 03:06:22 -0800 (PST)
In-Reply-To: <7v38xqba04.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.0 (GTK+ 2.24.13; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214545>

> Why do we want "whatever_7" variables and use "cut -c1-7" to produce
> them?  Is "7" something we care deeply about?
> 
> I think what we care a lot more than "7" that happens to be the
> current default value is to make sure that, if we ever update the
> default abbreviation length to a larger value, the abbreviation
> shown with --format=%h is consistent with the abbreviation that is
> given by rev-parse --short.
> 
>     head1_short=$(git rev-parse --short $head1)
> 
> perhaps?
> 
> > +	echo changed >foo &&
> > +	git commit -a -m "changed foo" &&
> > +	head2=$(git rev-parse --verify HEAD) &&
> > +	head2_7=$(echo $head2 | cut -c1-7) &&
> > +	head2_parent=$(git cat-file -p HEAD | grep parent | cut -f
> > 2 -d" ") &&
> 
> Do not use "cat-file -p" that is for human consumption in scripts,
> unless you are testing how the format for human consumption should
> look like (we may later add more pretty-print to them), which is not
> the case here.
> 
> Also be careful and pay attention to the end of the header; you do
> not want to pick up a random "parent" string in the middle of a log
> message.
> 
>     head2_parent=$(git cat-file commit HEAD | sed -n -e
> "s/^parent //p" -e "/^$/q")
> 
> would be much better.
> 
> > +	head2_parent_7=$(echo $head2_parent | cut -c1-7) &&
> > +	tree2=$(git cat-file -p HEAD | grep tree | cut -f 2 -d" ")
> > &&
> 
> Likewise.
> 
> > +	tree2_7=$(echo $tree2 | cut -c1-7)
> 
> Likewise.
but is there "git something" to return abbreviated tree hash except
"pretty formats" that is implicitly tested here?
