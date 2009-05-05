From: "Kana Natsuno" <kana@whileimautomaton.net>
Subject: Re: Two problems on alias of git
Date: Wed, 06 May 2009 00:11:32 +0900
Message-ID: <op.utgptirm6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
References: <op.utgiv92f6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
 <m3bpq7oddw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 17:12:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1MJv-0005jT-Aw
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 17:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbZEEPLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2009 11:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbZEEPLn
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 11:11:43 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:16360 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbZEEPLn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 11:11:43 -0400
Received: by mu-out-0910.google.com with SMTP id i2so1715024mue.1
        for <git@vger.kernel.org>; Tue, 05 May 2009 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:to:subject:from
         :cc:content-type:mime-version:references:content-transfer-encoding
         :message-id:in-reply-to:user-agent;
        bh=6+eGTVWdLtzbPeUtv33Se71E84F2pH+j3h2ny+l7zmI=;
        b=ZuhtyOxs/7Y/GrSlQ76C1y6bZSEGkEsR7dMyfeNJt1Uh0xVI4mx+Q2SvoK62fCAG3o
         2RzEV0hh7+zyUB1KwAgLjHFiWsLmLwppImolJaDVRsE1HFtUTuZek0kpAwP0W1x7V/O2
         e+vhiIxmTFFBdk0VcXC/y+IlGyrSQMOfePeWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:to:subject:from:cc:content-type:mime-version:references
         :content-transfer-encoding:message-id:in-reply-to:user-agent;
        b=WcgExRLM8m9AYVAXQomZO+TVCR5j5MMhboknUdiXsfv3/mNOK5SDbOp99heO02cRNg
         ird94tK6OmRtgrKyizX6Smlst+es/jF1dBOxbuF9Ii1FnrGsyg1rQHFl+x4z5MnSyoUO
         PCs0ktc7KBIVeUfDH+avHBxBIQCd7bkj62Ol8=
Received: by 10.143.38.6 with SMTP id q6mr64104wfj.70.1241536301172;
        Tue, 05 May 2009 08:11:41 -0700 (PDT)
Received: from i220-99-253-139.s27.a098.ap.plala.or.jp (i220-99-253-139.s27.a098.ap.plala.or.jp [220.99.253.139])
        by mx.google.com with ESMTPS id 22sm1359385wfg.27.2009.05.05.08.11.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 05 May 2009 08:11:40 -0700 (PDT)
In-Reply-To: <m3bpq7oddw.fsf@localhost.localdomain>
User-Agent: Opera Mail/9.63 (MacIntel)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118300>

On Tue, 05 May 2009 23:03:49 +0900, Jakub Narebski <jnareb@gmail.com> wrote:
> I don't know if it is a bug or a feature, but git-config supports
> quoted strings (required if you want to have value which has trailing
> or leading whitespace, or which contains '#' which is beginning of
> comment character).  Inside quoted string you need to escape '"':
>
>    [string]
>         quotes = "quoted \" string ' with # character"
>
> expands as intended.  Perhaps stripping of double quotes
> inside string are artifact of that feature.  Try escaping or
> double escaping quotes: \" or \\\".

Thank you for the information.  I've read the source code of git
and I confirmed that this stripping is caused by parse_value() in
config.c.


And as I changed the old definition

        lr = !$SHELL -c 'n=10; 1="${1:-$n}"; ...' __dummy__

by enclosing all text in double quotes and substituting '"' with
'\"' as follows,

	lr = "!$SHELL -c 'n=10; 1=\"${1:-$n}\"; ...' __dummy__"

it works well now.

	$ git config --get alias.lr
	!$SHELL -c 'n=10; 1="${1:-$n}"; if ! [ "${1##[0-9]*}" ...


-- 
To Vim, or not to Vim.
http://whileimautomaton.net/
