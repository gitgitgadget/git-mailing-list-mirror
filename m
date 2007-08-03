From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix unterminated string in set_work_tree and improve error handling
Date: Thu, 02 Aug 2007 23:29:10 -0700
Message-ID: <7v7iodqgg9.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0708022247s1116f66al1e8751f33bcae581@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 08:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGqey-0007sv-A0
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 08:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbXHCG3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 02:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755621AbXHCG3M
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 02:29:12 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61268 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862AbXHCG3M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 02:29:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070803062911.ORUG26965.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 3 Aug 2007 02:29:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XJVA1X0091kojtg0000000; Fri, 03 Aug 2007 02:29:10 -0400
In-Reply-To: <81b0412b0708022247s1116f66al1e8751f33bcae581@mail.gmail.com>
	(Alex Riesen's message of "Fri, 3 Aug 2007 07:47:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54675>

"Alex Riesen" <raa.lkml@gmail.com> writes:

>> >> Consolidating two of your patches, would this be Ok?
>> >
>> > Yes, but you may consider replacing strncpy with strlcpy:
>> >
>> >> +            memcpy(dir_buffer, dir, len - suffix_len);
>> >> +            dir_buffer[len - suffix_len] = '\0';
>> >
>> > strlcpy(dir_buffer, dir, len - suffix_len + 1);
>>
>> Does that buy us that much?  Before going to that codepath, we
>> have made sure the result fits, haven't we?

I sense you haven't read my replacement patch (Dscho Acked it).
I am talking about this part:

+	if (len > suffix_len &&
+	    !strcmp(dir + len - suffix_len, "/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
+		if ((len - suffix_len) >= sizeof(dir_buffer))
+			die("directory name too long");
+		memcpy(dir_buffer, dir, len - suffix_len);
+		dir_buffer[len - suffix_len] = '\0';
