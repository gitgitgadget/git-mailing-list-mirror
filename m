From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] Add proof-of-concept %[w(width,in1,in2)<<any-string>>%] implementation
Date: Fri, 16 Oct 2009 11:02:56 -0700 (PDT)
Message-ID: <m33a5jfc6p.fsf@localhost.localdomain>
References: <1255681702-5215-1-git-send-email-gitster@pobox.com>
	<1255681702-5215-4-git-send-email-gitster@pobox.com>
	<alpine.DEB.1.00.0910161331350.4985@pacific.mpi-cbg.de>
	<7vk4yvuu79.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 20:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myr8r-00057m-Ad
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 20:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbZJPSCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 14:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbZJPSCz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 14:02:55 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:65127 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZJPSCy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 14:02:54 -0400
Received: by fxm18 with SMTP id 18so2710396fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=B5uSDT/h9BbWmBS+olpNlkH88ix7Wej8VMsZQmFI/J4=;
        b=BI7ctAiVDAqr/BWdFx6Dyvld3t6DVRQgWbcWk7Ph/kaX+OnuGavdwBSUHqfUuftbaZ
         N+gdIlQTHIauZJkwgBkD9DlSI5iREHLz/D626ezpQHhsLFYI9uGH6COAol7xIUEVR0lh
         ScuzixP6zcoHkt7ZGWr44FadaVo6+1Lq3g5M0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TWqT4gbrYfShu4R7H3yGfCD4N0y3AzCfynaXUyoQ+v9Vr2BFOtiXPN6gmS526PG9Ws
         4aZZds8axM2oghy3oX1F/fGu+S6EzZwQwjDAxeIRdO2jUDHYVrqAVoRsU6lxAdIq3bhL
         OBAsJ7jgVheyv9w11tWywFMkUk23Yb594tnQ8=
Received: by 10.204.11.23 with SMTP id r23mr1642606bkr.158.1255716177763;
        Fri, 16 Oct 2009 11:02:57 -0700 (PDT)
Received: from localhost.localdomain (absh57.neoplus.adsl.tpnet.pl [83.8.127.57])
        by mx.google.com with ESMTPS id d6sm2612167fga.20.2009.10.16.11.02.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Oct 2009 11:02:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9GI44F9016530;
	Fri, 16 Oct 2009 20:04:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9GI3wWc016527;
	Fri, 16 Oct 2009 20:03:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vk4yvuu79.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130517>

Junio C Hamano <gitster@pobox.com> writes:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> maybe "rewrap" would be a better name than "w"?
> 
> Perhaps, but I do not know if wrap() is even better.  The only reason I
> said w() here is because I saw you used w() and this is meant to be a
> superset replacement for it, as this can re-wrap anything, not just one
> particular field from the commit object.

wrap(initial_prefix, subsequent_prefix, columns) would for example
follow somewhat Text::Wrap syntax, together with 'fill'.  With columns
being 0, not set, or negative it could simply indent result; this way
we finally would be able to get default git-log / git-rev-list format
using --pretty format.

I don't remember what were original parameters to w(72,4,8) means...

> 
>> On Fri, 16 Oct 2009, Junio C Hamano wrote:
>>
>>>   #1 "%[" introduces the nested string function.
>>> 
>>>   #2 After that, a name identifies what function to call.
>>> 
>>>   #3 The function parses its parameters ("(72,4,8)" in the above example),
>>>      and makes a nested expansion on the remainder of the format string.
>>
>> Can't we parse it once, i.e. the first time?
> 
> I may be missing the issue you are raising here, but it parses the string
> only once; it stuffs the expansion of the enclosed string into a separate
> buffer (while noting where it ends), applies the function to the result
> obtained in the separate buffer and appends the result of the function
> application to the main buffer, and the main expansion resumes where the
> nested one finished.

Do I understand it correctly that generic syntax is the following:

  %[function(params) format specifiers]

which would run given function, with given extra parameters, on the
result of expansion of the rest of the group?  That is a very
powerfull syntax... I wonder how other tools solved such problem...

BTW. can we have this also for git-for-each-ref format parameter?


Note that for single parameter we have different syntax (for
git-for-each-ref), namely

  %(field:modifier)

which could be expanded to allow for parametrized modifiers with one
of the following:

  %(field:modifier=param)
  %(field:modifier[param])
  %(field:modifier(param))

-- 
Jakub Narebski
Poland
ShadeHawk on #git
