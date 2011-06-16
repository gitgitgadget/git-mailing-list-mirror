From: James Blackburn <jamesblackburn@gmail.com>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 22:29:36 +0100
Message-ID: <BANLkTi=7yFdkNgvGX38JM_GbS7=tqf=1sQ@mail.gmail.com>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
	<m362o5vrhd.fsf@localhost.localdomain>
	<BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
	<20110616173451.GB6584@sigill.intra.peff.net>
	<7vy611hd38.fsf@alter.siamese.dyndns.org>
	<BANLkTikMNYyV40XM26rc6Ov6ZYO643mukA@mail.gmail.com>
	<7vlix1h8lz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 23:29:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXK8F-00011w-29
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 23:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758387Ab1FPV3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jun 2011 17:29:38 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62944 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281Ab1FPV3h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2011 17:29:37 -0400
Received: by qyk29 with SMTP id 29so168264qyk.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eb9aWeN7Pl4yKvwDeD/keuctpwOEeNA9E9er9Di0iZ4=;
        b=M9QldYaRy6e0PptybvKdtloYrZVaWx1P37gGMRnD29YsLfAq1nco7nRHxcuWDjso9+
         9oa19kgMpq2KIL1m+xtPpYGmUaA5fdx8y8f1cvXC9XexlweqHy1zAXpcgTcDOc9rqud/
         eVJS+PPq27gWLt3yfySB9xsXGMiuhg+jeUxrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Zuwvk/xRkFgLbexmtQ1Ck0B6KFEYE11NUTlW9O8dt2+wyj9M8lpQ/JH4lMsRj+c1sg
         zTLXeR0GOcliRqkSM/ieDWsIsXY8LKNtJMmXwHhPSt5gc5I0604oo8t0NqXATeoGnf8m
         m7DvLn9q7FIBxtXAdYp86XWfqKZ7Gk7oBJl30=
Received: by 10.229.111.98 with SMTP id r34mr1287375qcp.3.1308259776908; Thu,
 16 Jun 2011 14:29:36 -0700 (PDT)
Received: by 10.229.214.203 with HTTP; Thu, 16 Jun 2011 14:29:36 -0700 (PDT)
In-Reply-To: <7vlix1h8lz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175933>

On 16 June 2011 20:36, Junio C Hamano <gitster@pobox.com> wrote:
> James Blackburn <jamesblackburn@gmail.com> writes:
>
>> Given the file was removed during my 'merge' graft in commit X,
>> shouldn't it be visible =A0in log without --simplify-merges?
>
> The merge simplification logic does not treat earlier parent commits =
any
> differently than later parent commits of a merge (except when two par=
ents
> are the same with respect to a given pathspec, and if the logic needs=
 to
> pick only one, the earlier parent will be picked), and that is by des=
ign.
>
> So the short answer is no.

I think this is quite tough to grok.  Git blame shows me a path, and
git log -- <path> returns no output in the simple example I gave.

In this case --simplify-merges gives me a complete log for the path,
but man git-log tells me it should do the opposite:
       --simplify-merges
           Additional option to --full-history to remove some needless
merges from the resulting history, as there are
           no selected commits contributing to this merge.

I'm not sure how I would have figured out this switch might be just
the trick to show the commits that touched this path, without your
input.

As a naive user I expected:
  git log -- four
to tell we which commits changed the path 'four'. Especially those
commits which are reachable from my current HEAD.  I don't really
understand why one branch of history is worth following over another,
especially as the branch chosen, the older one, doesn't contain 'four'
at all.

Cheers,
James
