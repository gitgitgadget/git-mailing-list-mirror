From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Wed, 08 Jul 2009 09:42:34 -0700
Message-ID: <7viqi386th.fsf@alter.siamese.dyndns.org>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fritz Anderson <fritza@uchicago.edu>
X-From: git-owner@vger.kernel.org Wed Jul 08 18:42:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOaEM-00010n-OW
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 18:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbZGHQmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 12:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbZGHQmn
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 12:42:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbZGHQmm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 12:42:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 17CA0265D9;
	Wed,  8 Jul 2009 12:42:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B3FE8265D7; Wed, 
 8 Jul 2009 12:42:36 -0400 (EDT)
In-Reply-To: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu> (Fritz
 Anderson's message of "Wed\, 8 Jul 2009 10\:58\:48 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 59B9A4E6-6BDE-11DE-ABC3-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122904>

Fritz Anderson <fritza@uchicago.edu> writes:

> I get the error "fatal: index-pack failed" when I attempt to clone a  
> remote bare repository. The repository works well on other machines,  
> including the repository's own.
>
> The repository lives on a version of Mac OS X I'm not allowed to talk  
> about (I repeat: It works well for working copies on other machines,  
> and on its own). The client is RHEL5. Git is version 1.6.3 on both  
> machines, and was built from the tarball.

Looking at the output of the trace, I do not think that you have to worry
about people asking for a copy of your repository in order to diagnose
this issue, as I suspect that even a much smaller toy repository will fail
for you in the same way.

> Here's the debug transcript:

> ===========
> $ sudo GIT_TRACE=1 git clone myusername@remote.example.com:/Users/ 
> myusername/scientia/scientia.git

I have heard that pseudo resets the PATH so you are invoking "git" from
one of those standard system PATH, perhaps /usr/bin.

> trace: built-in: git 'clone' 'myusername@remote.example.com:/Users/ 
> myusername/scientia/scientia.git'
> Initialized empty Git repository in /srv/scientia/.git/
> trace: run_command: 'ssh' 'myusername@remote.example.com' 'git-upload- 
> pack '\''/Users/myusername/scientia/scientia.git'\'''
> Password:
> trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin' '-- 
> keep=fetch-pack 17580 on local.example.com'
> trace: exec: 'git' 'index-pack' '--stdin' '-v' '--fix-thin' '-- 
> keep=fetch-pack 17580 on local.example.com'
> trace: exec failed: No such file or directory
> trace: exec 'index-pack' failed: No such file or directory

This is saying that "git" on the local side (the one you are running
"clone" on) couldn't find its "index-pack" subcommand.  Why?

I think this is an issue with your RHEL5 box, not the MacOS box.  A quick
check that might be useful is to type:

	$ git index-pack
	$ sudo git index-pack
