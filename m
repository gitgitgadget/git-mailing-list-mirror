From: Paul Smith <paul@mad-scientist.net>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH
 compatibility
Date: Mon, 11 Mar 2013 14:19:44 -0400
Organization: GNU's Not UNIX!
Message-ID: <1363025984.24833.19.camel@pdsdesk>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr>
	 <7v38w1c3ms.fsf@alter.siamese.dyndns.org> <513E0FB4.40607@gmail.com>
	 <7v8v5talzu.fsf@alter.siamese.dyndns.org> <vpqppz5u8te.fsf@grenoble-inp.fr>
	 <7vwqtd95bm.fsf@alter.siamese.dyndns.org>
Reply-To: paul@mad-scientist.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Manlio Perillo <manlio.perillo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 19:20:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF7Ki-00046p-Cl
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 19:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082Ab3CKST6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 14:19:58 -0400
Received: from oproxy5-pub.bluehost.com ([67.222.38.55]:51056 "HELO
	oproxy5-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752041Ab3CKST4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 14:19:56 -0400
Received: (qmail 10939 invoked by uid 0); 11 Mar 2013 18:19:55 -0000
Received: from unknown (HELO box531.bluehost.com) (74.220.219.131)
  by cpoproxy2.bluehost.com with SMTP; 11 Mar 2013 18:19:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mad-scientist.net; s=default;
	h=Content-Transfer-Encoding:Mime-Version:Content-Type:References:In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID; bh=9Y6KbDa9uPfgK2bub83mmOhbGCxdLgWLrScwLwjWTSM=;
	b=XY7hR63Tpdh5irGBgnHeYdMjBse6PA1V2QOfngV+osd67fUlkL6qalKTBVDWqh+wWo3QW+nFCT16becu7u8FZ9bbOYu8P9xk3DATICIHcGeGfcHim0KibBCMw/Uk7Xgo;
Received: from [173.9.45.73] (port=53567 helo=[10.1.37.145])
	by box531.bluehost.com with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.80)
	(envelope-from <paul@mad-scientist.net>)
	id 1UF7KD-0001Ap-23; Mon, 11 Mar 2013 12:19:53 -0600
In-Reply-To: <7vwqtd95bm.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.6.4 
X-Identified-User: {678:box531.bluehost.com:madscie1:mad-scientist.us} {sentby:smtp auth 173.9.45.73 authed with paul+mad-scientist.us}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217898>

On Mon, 2013-03-11 at 11:09 -0700, Junio C Hamano wrote:
> So strictly speaking there is no reason for an extra subshell here,
> but writing this in the way the patch does makes our intention
> crystal clear, I think.

If you're concerned about the extra processing of the new shell you can
use {} instead of ():

        {
            test -n "${CDPATH+set}" && unset CDPATH
            # NOTE: $2 is not quoted in order to support multiple options
            cd "$1" && git ls-files --exclude-standard $2
        } 2>/dev/null

Zsh does support this properly in my testing.  It's only redirection of
an entire function body, as the original, that is working differently in
zsh and bash.
