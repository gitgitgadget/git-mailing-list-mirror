From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone stable-2.6.25.y fails over HTTP
Date: Thu, 05 Jun 2008 14:26:11 -0700
Message-ID: <7vzlpzzi8c.fsf@gitster.siamese.dyndns.org>
References: <200806041511.m54FBPL9006783@pogo.cesa.opbu.xerox.com>
 <20080604154523.GA25747@kroah.com>
 <7vr6bdxh3l.fsf@gitster.siamese.dyndns.org>
 <20080605040315.GA21798@kroah.com>
 <7vabi05xl1.fsf@gitster.siamese.dyndns.org>
 <20080605050855.GA22825@kroah.com>
 <alpine.LNX.1.00.0806051546480.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Jun 05 23:27:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4MzP-0002zr-2L
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 23:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbYFEV0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 17:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYFEV0Y
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 17:26:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbYFEV0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 17:26:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E7B9336B6;
	Thu,  5 Jun 2008 17:26:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0229036B0; Thu,  5 Jun 2008 17:26:13 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0806051546480.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 5 Jun 2008 16:53:57 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 09FE42E4-3346-11DD-BAC7-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83986>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Wed, 4 Jun 2008, Greg KH wrote:
> ...
>> I can duplicate what I did, and it did it again:
>> 	on master.kernel.org:
>> 	$ cd /pub/scm/linux/kernel/git/stable/
>> 	$ git clone -s --bare ../torvalds/linux-2.6.git/ test
>> 	$ cat test/objects/info/alternates
>> 	/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
>> 
>> I'm guessing this is because /pub/ is a symlink:
>> 	$ ls -l /pub
>> 	lrwxrwxrwx 1 root root 13 Feb  4  2006 /pub -> /home/ftp/pub
>
> We're using getcwd() to make the absolute path, but it looks like we 
> should check whether $PWD is set and names the same directory, and, if so, 
> base on that instead.
>
> Actually, make_absolute_path() seems to go to an awful lot of trouble to 
> make sure that there aren't symlinks in the resulting path. Is this 
> actually necessary or even desireable for some reason? Should clone be 
> just pasting $PWD (or, failing that, getcwd()) and the given path, and 
> using that to identify the repo to clone?

I am not 100% sympathetic if ../torvalds/linux-2.6.git/ was what caused
this.  Perhaps 30% or so ;-).

However, I think /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ would
result in the same breakage, and that is something I consider gravely
broken.

If both are fixed by rethinking the make_absolute_path(), that would be
good.
