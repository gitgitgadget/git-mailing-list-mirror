From: xmeng@cs.wisc.edu
Subject: Re: A generalization of git blame
Date: Wed, 26 Sep 2012 10:36:46 -0500
Message-ID: <72fc15c78ddb6b5c9e95f6b0cd925a26.squirrel@webmail.cs.wisc.edu>
References: <89ccf5dd776edc648d488c20214e1105.squirrel@webmail.cs.wisc.edu>
    <CC2642CD25C542A18FB55E7BD58F95E5@PhilipOakley>
    <7vsja5vh2z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Philip Oakley" <philipoakley@iee.org>, xmeng@cs.wisc.edu,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 17:47:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGtpM-0006l1-6Y
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 17:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661Ab2IZPq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 11:46:58 -0400
Received: from sandstone.cs.wisc.edu ([128.105.6.39]:40708 "EHLO
	sandstone.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab2IZPq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 11:46:57 -0400
Received: from webmail.cs.wisc.edu (slappy.cs.wisc.edu [128.105.7.37])
	by sandstone.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id q8QFajER012190;
	Wed, 26 Sep 2012 10:36:46 -0500
Received: from 128.105.14.84
        (SquirrelMail authenticated user xmeng)
        by webmail.cs.wisc.edu with HTTP;
        Wed, 26 Sep 2012 10:36:46 -0500
In-Reply-To: <7vsja5vh2z.fsf@alter.siamese.dyndns.org>
User-Agent: SquirrelMail/1.4.22
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206421>


> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> To get ground truth of authorship for each line, I start with
>>> git-blame.
>>> But later I find this is not sufficient because the last commit may
>>> only
>>> add comments or may only change a small part of the line, so that I
>>> shouldn't attribute the line of code to the last author.
>>
>> I would suggest there is:
>> - White space adjustment
>> - Comment or documentation (assumes you can parse the 'code' to decide
>> that it isn't executable code)
>> - word changes within expressions
>> - complete replacement of line (whole statement?)
>
> You are being generous by listing easier cases ;-) I'd add a couple
> more that are more problematic if your approach does not consider
> semantics.
>
>  - A function gained a new parameter, to which pretty much everbody
>    passes the same default value.
>
> 	-void fn(int a, int b, int c)
> 	+void fn(int a, int b, int c, int d)
> 	 {
> 	+	if (d) {
> 	+		...
> 	+		return;
> 	+	}
> 		...
> 	 }
>
>          void frotz(void)
> 	 {
> 		...
>         -	fn(a, b, c);
>         +	fn(a, b, c, 0);
>         	...
>         -	fn(a, b, d);
>         +	fn(a, b, d, 1);
>         	...
>
>    The same commit that changed the above call site must have
>    changed the definition of function "fn" and defined what the new
>    fourth parameter means.  It is likely that, when the default
>    value most everybody passes (perhaps "0") is given, "fn" does
>    what it used to do, and a different value may trigger a new
>    behaviour of "fn".  It could be argued that the former call
>    should not be blamed for this commit, while the latter callsite
>    should.
>
>  - A variable was renamed, and the meaning of a line suddenly
>    changed, even though the text of that line did not change at all.
>
> 	 static int foo;
>          ...
>         -int xyzzy(int foo)
> 	+int xyzzy(int bar)
> 	 {
> 		... some complex computation that
>                 ... involves foo and bar, resulting in
>                 ... updating of foo comes here ...
> 		return foo * 2;
>  	 }
>
>    Whom to blame the behaviour of (i.e. returned value from) the
>    function?  The "return foo * 2" never changed with this patch,
>    but the patch _is_ responsible for changing the behaviour.
>
>    As the OP is interested in tracking the origin of the _binary_,
>    this case is even more interesting, as the generated machine code
>    to compute the foo * 2 would likely to be very different before
>    and after the patch.
>
>

Thanks for both your great suggestions. Current my approach doesn't
consider semantics yet and this should be an interesting to do.

Another question is that is it possible to include my tool as a git
built-in tool in the future? I know that my tool is still not good for any
release. But I would like to share my work with other people if other
people are interested. And if it is possible, I think I will have a
stronger motivation to make my tool more robust and useful.

Thanks
