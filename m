From: Brandon Casey <drafnel@gmail.com>
Subject: Re: How to still kill git fetch with too many refs
Date: Tue, 2 Jul 2013 10:52:47 -0700
Message-ID: <CA+sFfMf4Y2zPYhewADxJyR8DR5aAsa89+PW2UDNp3zSsXqjUHA@mail.gmail.com>
References: <201307012102.31384.mfick@codeaurora.org>
	<20130702040758.GA7068@sigill.intra.peff.net>
	<20130702044151.GB7068@sigill.intra.peff.net>
	<20130702050142.GA1206@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Fick <mfick@codeaurora.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 02 19:52:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu4l3-0007g1-Bt
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 19:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457Ab3GBRwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 13:52:49 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:57113 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222Ab3GBRws (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 13:52:48 -0400
Received: by mail-wg0-f47.google.com with SMTP id l18so4913890wgh.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FFCMNx5wNMrMf7aKRUEGOe/JHYlDhA7jYe2P+Ll2R0c=;
        b=srfDtqoE/vTVjd1I+ZGHRjq2kcdQgD/r8aNunXIupKOEjEfyUKoIBJjwhqPqIU44KI
         uSEnYWmlTTamxmH1aB9Xbe1vCz91tarQvG3Dj0Rs8pOOcZQpDMIuhprNRi1UVXfuFzbT
         OzS0yJQHAvPfeL7HG2Wr95/8SqtdUWGC8UYA71gIFDj+8bpIkJhT9L2N+XWMEDJH3JFa
         BNu5yQmFbZYFtCdZF/x19TnB4/gE2xCNmL7Oz2na6xeHA5NigSsBWJ+P5GdTSsOi/lE1
         ZLh4efR1xSsHBOTRQ7GD31qCADHtHZHH2DoHeg0wTUU0rIhlh6dfG4Zdv9/CVFrivtNi
         PRnw==
X-Received: by 10.194.234.100 with SMTP id ud4mr15566625wjc.44.1372787567681;
 Tue, 02 Jul 2013 10:52:47 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Tue, 2 Jul 2013 10:52:47 -0700 (PDT)
In-Reply-To: <20130702050142.GA1206@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229411>

On Mon, Jul 1, 2013 at 10:01 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 02, 2013 at 12:41:51AM -0400, Jeff King wrote:
>
>> I replicated your test setup, and the problem is that we have many
>> common objects on both sides during the ref negotiation. So we end up in
>> rev_list_push for each one, which has the same O(n^2) behavior.
>> Switching it to just sort at the end is not trivial; we first insert all
>> of the objects, but then we actually walk the parents, pushing onto the
>> list as we go. So I think we'd want a better data structure (like a
>> priority queue).
>
> Like the patch below,

<snip>

Looks obviously correct to me since I've got essentially the same
patch sitting in my local repo. :b

I've got the patch coming that fixes the same problem on the push side
of things and provides the same order of magnitude improvement.

-Brandon
