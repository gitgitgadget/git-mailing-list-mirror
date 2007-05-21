From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH v2] Submodule merge support
Date: Mon, 21 May 2007 00:54:20 -0700
Message-ID: <7vabvyfw7n.fsf@assigned-by-dhcp.cox.net>
References: <20070520154227.GG5412@admingilde.org>
	<20070521062005.GK3141@spearce.org>
	<20070521073253.GU5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 21 09:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq2ir-0003Xs-QU
	for gcvg-git@gmane.org; Mon, 21 May 2007 09:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbXEUHyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 03:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754955AbXEUHyW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 03:54:22 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:60322 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbXEUHyV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 03:54:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521075420.KQSE2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 21 May 2007 03:54:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1juL1X0051kojtg0000000; Mon, 21 May 2007 03:54:20 -0400
In-Reply-To: <20070521073253.GU5412@admingilde.org> (Martin Waitz's message of
	"Mon, 21 May 2007 09:32:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47987>

Martin Waitz <tali@admingilde.org> writes:

>> > +		if (S_ISDIRLNK(mode)) {
>> > +			/* defer dirlinks to another process, don't try to */
>> > +			/* read the object "sha" here */
>> > +			const char *dirlink_checkout[] = {
>> > +				"dirlink-checkout", path, sha1_to_hex(sha), NULL
>> > +			};
>> > +			struct child_process cmd = {
>> > +				.argv = dirlink_checkout,
>> > +				.git_cmd = 1,
>> > +			};
>> 
>> My Solaris 9 system cannot compile this syntax, even though it is
>> a clean way to initalize the child_process.
>
> any special thing it does not like in the above code or does it just
> not support structs that are initialized that way?

Portability rules:

 - We do not do C99 initializers;
 - We do not do decl-after-statement;

Readability rules:

 - We always write NULL, not 0, for a NULL pointer.

There may be a handful more unwritten rules we use.

>> > +	status = read(cmd.out, hex, sizeof(hex));
>> > +	if (status != 40) return status;
>> 
>> OK, this is probably just never trusting the OS, but shouldn't that
>> read be wrapped up in a loop, like our read_in_full?  We want 40
>> bytes here, and expect it, and the read call is allowed to return
>> as few as 1 byte....
>
> right.

I think we have read-in-full or something like that for this
exact purpose.
