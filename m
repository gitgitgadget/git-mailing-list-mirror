From: Junio C Hamano <gitster@pobox.com>
Subject: bug in "git log --graph" at the tail end?
Date: Fri, 23 May 2008 13:42:56 -0700
Message-ID: <7vve14rbu7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Fri May 23 22:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jze7Y-0000v9-NB
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759750AbYEWUnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759737AbYEWUnG
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:43:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759628AbYEWUnE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:43:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FF965B01;
	Fri, 23 May 2008 16:43:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CDE955AFD; Fri, 23 May 2008 16:42:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D66FD236-2908-11DD-8F6C-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82758>

It appears that "log --graph" output has a bug at its tail end.

    $ git log --pretty=oneline --abbrev-commit --graph 9d88058^..1af8bca
    M   1af8bca... Merge branch 'maint'
    |\  
    | M   008442f... Merge branch 'maint-1.5.4' into maint
    | |\  
    | * e77b0b5... git-am: fix typo in usage message
    | * 74190d2... doc/git-daemon: s/uploadarchive/uploadarch/
    M   9d88058... Merge branch 'ar/add-unreadable'
    |\  
    * dad25e4... Add a config option to ignore errors for git-add
    * 8959743... Add a test for git-add --ignore-errors
    * 984b83e... Add --ignore-errors to git-add to allow it to sk...
    * 7ae02a3... Extend interface of add_files_to_cache to allow ...
    * 960b8ad... Make the exit code of add_file_to_index actually...

Ideally, I think the output should look like this:

    M   1af8bca... Merge branch 'maint'
    |\  
    | M   008442f... Merge branch 'maint-1.5.4' into maint
    | |\  
    | * e77b0b5... git-am: fix typo in usage message
    | * 74190d2... doc/git-daemon: s/uploadarchive/uploadarch/
    M   9d88058... Merge branch 'ar/add-unreadable'
    |\  
    | * dad25e4... Add a config option to ignore errors for git-add
    | * 8959743... Add a test for git-add --ignore-errors
    | * 984b83e... Add --ignore-errors to git-add to allow it to sk...
    | * 7ae02a3... Extend interface of add_files_to_cache to allow ...
    | * 960b8ad... Make the exit code of add_file_to_index actually...

This is purely cosmetic, but because --graph is only about the cosmetics,
we may want to do something about it.

Thoughts?
