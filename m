From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCHv3 3/4] git-status: show short sequencer state
Date: Wed, 14 Nov 2012 14:14:18 -0500
Message-ID: <50A3ED8A.9080604@cisco.com>
References: <1351553513-20385-1-git-send-email-hordp@cisco.com> <1352487385-5929-1-git-send-email-hordp@cisco.com> <1352487385-5929-4-git-send-email-hordp@cisco.com> <7vip9aiuk8.fsf@alter.siamese.dyndns.org> <50A13C9A.8070108@cisco.com> <50A2DCD7.4050909@cisco.com> <7vy5i4b9d8.fsf@alter.siamese.dyndns.org> <50A3A040.7040304@cisco.com> <7vfw4caxkh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Jeff King <peff@peff.net>, konglu@minatec.inpg.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kong Lucien <Lucien.Kong@ensimag.imag.fr>,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:14:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYiQI-0001L9-BB
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 20:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423274Ab2KNTOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 14:14:22 -0500
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:33998 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423253Ab2KNTOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 14:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2211; q=dns/txt; s=iport;
  t=1352920459; x=1354130059;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=u2KRzaM4imZ+BNZ1K0t3AGkc/KFskCCfXRhOh2RsLsE=;
  b=Dbe7I8e6EWEQYdX8c9Dm+aAMUtD0y81LZO/Rc3xBstpBmQs2bTihv5Yg
   2xTB651pLwylWih2KOXOuJL8JsWDgN0PGBBJUgYV4VRAqX+f26/mpOPBr
   yxx1ChHH7XMp+ltrTBQ8OL5YB/lR8zdW21qV0a5LB33tB6wiSb7kBiglK
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EAKvso1CtJXG+/2dsb2JhbABEwziBCIIeAQEBAwESAWUBEAsYCRYPCQMCAQIBRQYNAQUCAQEeh2IGmyegE5JZA4hajSKFa4htgWuDDQ
X-IronPort-AV: E=McAfee;i="5400,1158,6896"; a="142445147"
Received: from rcdn-core2-3.cisco.com ([173.37.113.190])
  by rcdn-iport-3.cisco.com with ESMTP; 14 Nov 2012 19:14:18 +0000
Received: from [64.100.104.138] (dhcp-64-100-104-138.cisco.com [64.100.104.138])
	by rcdn-core2-3.cisco.com (8.14.5/8.14.5) with ESMTP id qAEJEIeG031683;
	Wed, 14 Nov 2012 19:14:18 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <7vfw4caxkh.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.5
X-TagToolbar-Keys: D20121114141418141
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209741>


Junio C Hamano wrote:
> Phil Hord <hordp@cisco.com> writes:
>
>> Consider the usage:
>>
>>   git status   # show work-tree status
>>   git status --short  # show short work-tree status
>>   git status --tokens  # show work-tree status in token form
> OK, your --tokens is more about *how* things are output, but it is
> unclear how it would interact with --short.  I had an impression
> that you are basing your output on the short output, whose existing
> record include "##" (that shows the branch names and states), and
> "MM", "A " and friends (that show the per-file states), by adding
> new record types that shows tree-wide states.

I am, but I don't much care for the "##" prefix, especially when
combined with --null, for example.  I'm inclined to remove it when
--short is not provided, specifically to give scripts an easier time of
parsing.  But scripts are likely to need "--porcelain" as well, and
currently that implies "--short".  But I suppose another combination
could be meaningful.

  # tokens only
  $ git status --tree
  changed-files

  # tokens and short-status
  $ git status --tree --short  
  ## changed-files
   M foo.txt

  # short-status only
  $ git status --porcelain
   M foo.txt

  # tokens only?
  $ git status --tree --porcelain
  changed-files

I think this spaghettify's the ui too much.  Maybe this instead:

  # undecorated tokens only
  $ git status --tree=porcelain
  changed-files


>
>> But maybe "--tokens" has some better meaning that someone will want to
>> use in the future.  I'm not married to it.  But "git status" already
>> means "Show the working tree status".  So "git status --show-tree-state"
>> sounds redundant or meaningless.
> I didn't mean to say that you have to spell out all these words;
> "show" and "state" are redundant.
>
> The important part is that unlike the existing "per-file" state the
> "status" command is showing, the option is to add "tree-wide" state
> to the output, and my suggestion was to pick a word that makes it
> clear, rather than using "output is done using tokens" without
> saying "what is being output in tokenized form".

Thanks for clarifying. 

Phil
