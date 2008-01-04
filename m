From: Christian Thaeter <ct@pipapo.org>
Subject: libgit: git_setup_directory() is not reentrant
Date: Fri, 04 Jan 2008 18:07:17 +0100
Message-ID: <477E67C5.5020301@pipapo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 18:08:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAq1L-0003oR-T8
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 18:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYADRHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 12:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbYADRHU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 12:07:20 -0500
Received: from pipapo.org ([217.140.77.75]:4494 "EHLO mail.pipapo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbYADRHT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 12:07:19 -0500
Received: from [10.20.70.10] (mercur.pipapo.org [10.20.70.10])
	by mail.pipapo.org (Postfix) with ESMTP id 9F87A34F6B94D
	for <git@vger.kernel.org>; Fri,  4 Jan 2008 18:07:17 +0100 (CET)
User-Agent: Icedove 1.5.0.14pre (X11/20071018)
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69583>

While working on a git-browser, I noticed that git_setup_directory() is
not reentrant. Once called it initializes (by calling other functions in
turn) several static/hidden variables which can't be altered afterwards.
This is ugly when one wants  to iterate over different repositories
(generating a list of available repos).

How could we fix this?
I would propose that subsequent 'git_setup_directory()' calls will
reinit the setup completely.

Another way would be to provide a 'git_setup_reset()' function which
lets one cleanup all setup things before calling 'git_setup_directory()'
again.

Comments?

	Christian
