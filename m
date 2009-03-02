From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] send-email: add --confirm option
Date: Mon, 02 Mar 2009 17:24:01 +0900
Message-ID: <20090302172401.6117@nanako3.lavabit.com>
References: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
 <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
 <7d1d9c250903010909h7d92f165oc703a05e819671a4@mail.gmail.com>
 <76718490903010949h7b64eb97ob567101fbc7e4cd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 09:25:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le3TF-0007xH-3z
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 09:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbZCBIY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 03:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754380AbZCBIYZ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 03:24:25 -0500
Received: from karen.lavabit.com ([72.249.41.33]:53777 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754197AbZCBIYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 03:24:24 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 3638111B836;
	Mon,  2 Mar 2009 02:24:22 -0600 (CST)
Received: from 5901.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id ZEJBE2RB68AF; Mon, 02 Mar 2009 02:24:22 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ODBQJTSS5il6u/VJ1Bg2In4Aa8QVtOenL3jGGU6le7c0nEIXYhgtPb1QJLjQ0pzv0d1/l8+SdJoDbH7dElouKKCBrNTWF+lcSHy83WVMekepgWA0/e9oIx+y9UbBNt3s83b82e/u7bCxQUpKsrLtdEjeppJh3Qx32aAbXL+fhEM=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <76718490903010949h7b64eb97ob567101fbc7e4cd1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111916>

Quoting Jay Soffian <jaysoffian@gmail.com>:

> (Please correct me if my summary is wrong, but that's how I recall it.)

I think your summary has some things right.

 - Many people complained git-foo being on their paths in the past;
 - Version 1.6.0 removed git-foo from users' path; and
 - Many people didn't like the change after the fact.

However, you are completely wrong about the escape hatch.

If your judgement on how seriously you need to treat the backward compatibility is based on your understanding of the issue you summarized in your message, you need to reconsider what you are proposing, after learning from the true history.

The transition plan was first announced officially as part of the
release notes for version 1.5.4. It said three things:

 - Using dashed forms of git commands (e.g. "git-commit") from the
   command line has been informally deprecated since early 2006, but
   now it officially is, and will be removed in the future.  Use
   dash-less forms (e.g. "git commit") instead.

 - Using dashed forms from your scripts, without first prepending the
   return value from "git --exec-path" to the scripts' PATH, has been
   informally deprecated since early 2006, but now it officially is.

 - Use of dashed forms with "PATH=$(git --exec-path):$PATH; export
   PATH" early in your script is not deprecated with this change.

Notice that:

 - "now" is December 1st, 2007.

 - "will be removed in the future" happened on August 17th, 2008 at version 1.6.0.

 - The notice EXPLICITLY promises to keep supporting the use of git-foo if you prepend output of 'git --exec-path'.

In other words, there was an escape hatch that had been very carefully in preparation for nine months. The same escape hach, and the promise to keep supporting it, was repeated in the release notes for version 1.6.0.

You can refresh your memory (or read it for the first time, if you weren't around back then) with a message from Junio on August 24th, 2008 after version 1.6.0 was released:

http://thread.gmane.org/gmane.comp.version-control.git/93511

It summarized "the original plan" (read the message and find the phrase in the middle) and outlined how it should be implemented if the git community still wanted to go through with the plan.

With the discussion that followed the message, the community decided not to do anything (also known as the "alternative A").

The escape hatch was there from the beginning, is still there, and it will remain there. I should also add that it was Junio's veto of Linus'es proposal to stop installing git-foo commands for builtins that enabled this escape hatch.

http://thread.gmane.org/gmane.comp.version-control.git/51245/focus=51272

By the way, I don't think the lesson you should take home is the need for an escape hatch. Read the message by Junio on August 24th, 2008. Being nice and not too loud during the deprecation period kept users complacent about upcoming changes and upset them when the change finally came. Being un-nice and too loud during the deprecation period would have upset them early instead. You cannot avoid upsetting users either way whenever you change the behavior. That's the lesson you should learn.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
