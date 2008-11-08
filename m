From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: Init on push
Date: Sat, 8 Nov 2008 23:01:02 +0300
Message-ID: <bb6f213e0811081201w22a36800j1713b91d0cf66fb2@mail.gmail.com>
References: <200811081708.45672.robin.rosenberg.lists@dewire.com>
	 <7viqqyc93w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 21:02:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyu0i-0007b9-C8
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 21:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYKHUBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 15:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbYKHUBE
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 15:01:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:49262 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYKHUBD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 15:01:03 -0500
Received: by wa-out-1112.google.com with SMTP id v27so905701wah.21
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 12:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=t9oAHbE6koFbz5npowactVya/A//OkoaPyo0YJ0uOK8=;
        b=PTs52CwjRVaQSAjlBRhivqu4o4a7k+EpJ8efeSlw1hGOmZcWJEyVEqlVsSqLQFnm05
         noUbZu3zsVfee3bThvGTVnCM465fL+IVWpaKGjku2M8Nele86Yef/1VoqB/4QckHgY6P
         JQSG5uo42/KbIEeujRiJvhddUSjm/XH2rFwO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eeFX9IbtXYSwfp57aSqpf7ztp6CtOJ8K5HCtF8A6oJFUKwQq0E3bGdE5xTtzqjFnvW
         mWyTUv1fhKPCUWE1pZ7exTRHTocY5KuggMzn9ONKOM8FLrcxyBRKeG2dsz4ce832jUgW
         HEaOEsj/CoMMeODVJhb6pR9J8tp+MVYDgO6Dw=
Received: by 10.115.106.18 with SMTP id i18mr2556015wam.213.1226174462612;
        Sat, 08 Nov 2008 12:01:02 -0800 (PST)
Received: by 10.142.216.21 with HTTP; Sat, 8 Nov 2008 12:01:02 -0800 (PST)
In-Reply-To: <7viqqyc93w.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100417>

On Sat, Nov 8, 2008 at 10:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> An easy alternative would be to issue the usual "mkdir && git init" shell
> script before spawning receive-pack.  This will limit the feature to
> pushing over the ssh transport, and pushing over the git protocol against
> a loose git-daemon will not be able to support it.  Also I suspect this
> will break sites managed by gitosis, where all repositories are held under
> the same UNIX user identity, differenciated only via an environment it
> sets based on the ssh key used to make the connection.

Gitosis works by replacing the shell with a program called
gitosis-serve, which parses and validates the incoming commands
against the user access configuration. If it sees an unknown command,
it will simply refuse to execute it.

On the other hand it will automatically perform initialization before
calling receive-pack if the user is authorized to write to a certain
path, but the repository does not exist yet.

Alexander
