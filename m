From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] perl/Git.pm: moving away from using Error.pm module
Date: Mon, 21 Feb 2011 13:12:44 +0100
Message-ID: <201102211312.48333.jnareb@gmail.com>
References: <201102202346.36410.jnareb@gmail.com> <7v4o7xluph.fsf@alter.siamese.dyndns.org> <4D624632.80904@letterboxes.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Alex Riesen <raa.lkml@gmail.com>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Nick <oinksocket@letterboxes.org>
X-From: git-owner@vger.kernel.org Mon Feb 21 13:24:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrUo4-0004Os-Gx
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 13:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905Ab1BUMX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 07:23:56 -0500
Received: from mail-bw0-f42.google.com ([209.85.214.42]:47075 "EHLO
	mail-bw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840Ab1BUMXz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 07:23:55 -0500
Received: by bwz13 with SMTP id 13so2412129bwz.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 04:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=IWANXacgcucmCp3oAY9fKBsA2ouWR3dj2advRVoeK80=;
        b=nIpfz9oIKhq4kOkQfAIBJ9xeu6LzRCfgqMa7rE1UGDyaRnQ3RGrwV2Nerdq4LsnnMz
         Nv2QwT7FAxAo/C0P4rHtTVHMoSRXLo8hv7zf8nJn1pK3KRd4oxrMgM+zP5Db4Ge1FXGp
         ln14U5SDgzPhl4AGl3BaT+oyympF2NQIqMgO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LwNB30naVM1L4v/oJhfCJG4sgPNzv6KGdD63CgJRbb0AutL73tE/Co1pZNjv84zqCj
         LbYLb0fjaKJE/srC3quYdh+Kowqvx5xgucMkkDux75F6tFL1yPNP+SO1NzVuvQGDLWlp
         bBfRGiydvxzVOIKrYm+2HO1Ip//r7eGhOs21Y=
Received: by 10.204.138.130 with SMTP id a2mr1210540bku.211.1298290381759;
        Mon, 21 Feb 2011 04:13:01 -0800 (PST)
Received: from [192.168.1.13] (abwh41.neoplus.adsl.tpnet.pl [83.8.231.41])
        by mx.google.com with ESMTPS id z18sm3661984bkf.20.2011.02.21.04.12.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 04:13:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D624632.80904@letterboxes.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167473>

On Mon, 21 Feb 2011, Nick wrote:
> On 21/02/11 07:20, Junio C Hamano wrote:

> > If we are going to change things so that everybody uses a
> > more traditional "eval {}; if ($@) { ... }", it would be a welcome change
> > from my point of view.
> 
> A small aside - note the "Dangers of using $@" described here:
> 
>   http://www.socialtext.net/perl5/exception_handling
> 
> To paraphrase, this:
> 
>   eval { stuff ; 1} or do { handle_exception };
> 
> is marginally safer than:
> 
>   eval { stuff }; if (defined $@) { handle_exception }

Important note: it is "if ($@)", not "if (defined $@)":

  If there was no error, $@ is guaranteed to be a null string.
                                                  ^^^^^^^^^^^

It is empty string, not undef.

> because it is possible that $@ can be modified (say, by a DESTROY method) before
> the if clause sees it.  The former idiom does not stop that, it just means your
> exception handler is executed reliably.
> 
> Normally it is not a problem, but this is still something worth knowing.

Or better use Try::Tiny, which takes care of this and more

  use Try::Tiny;
  try { stuff  } catch { handle_exception };

-- 
Jakub Narebski
Poland
