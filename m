From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: New to Git / Questions about single user / multiple projects
Date: Wed, 19 Aug 2009 14:18:07 +0200
Message-ID: <200908191418.08838.jnareb@gmail.com>
References: <a2db4dd50908181852s1e2c64fen8b883faf76b3136d@mail.gmail.com> <m3ab1wnsie.fsf@localhost.localdomain> <a2db4dd50908190400x1cbb1506sa38c60e31587f49d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Rob (gmail)" <robvanb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 14:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdk7Y-000425-Hq
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 14:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbZHSMST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 08:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbZHSMST
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 08:18:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:21850 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbZHSMST (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 08:18:19 -0400
Received: by fg-out-1718.google.com with SMTP id e12so783951fga.17
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 05:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=XnH4ufQ6SS0QgnSoy78zKP0ZJ9CJBJfu4CnxmJtlUTA=;
        b=VIBEfjisO8k0+oA96z6cjDPuQnj3qQqjIuIGSjZWTPNn3xcrXqYEhAPrV2p+VOYTkx
         ABoUO1wgrlHNgIffzW1DQzUBc7WEHlOm84QMzdT0JPBtABypAVdB/F0eVuCuSnFZjT5Z
         Bk8yrusqTSwI4FV1pvJwOexUMtI6VGounm370=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ZstOzIz6K0UhwLA2EU5dyQ1u+GRGVsQXrNk+2IRG/LIxiEIlhIpLYVULSgdM2lrEHC
         C1hZQL5fBppAOgjAVlXsdKqdwAUfzFuiVJk+Nlryn6rJCJMRgkVthGeipIPEuc2JHZ8I
         DUIl9T1uUV2LmL9tbhT68aikfmotqoMl7BJb4=
Received: by 10.86.169.25 with SMTP id r25mr4149707fge.17.1250684299529;
        Wed, 19 Aug 2009 05:18:19 -0700 (PDT)
Received: from ?192.168.1.13? (abvk137.neoplus.adsl.tpnet.pl [83.8.208.137])
        by mx.google.com with ESMTPS id e20sm8286143fga.2.2009.08.19.05.18.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 05:18:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <a2db4dd50908190400x1cbb1506sa38c60e31587f49d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126536>

Please do not toppost, and when responding cull the quoted part, 
so only those parts that are relevant to your reply are remaining.

On Wed, 19 Aug 2009, Rob wrote:

> Thanks all for all the answers :)
> 
> One last question based on the multiple projects issue:
> Is there a command that lists all your projects ?
> 
> My initial thought is that there probably isn't, as there is no
> relation between the project except the userID ?

No, there no git commands for listing all your projects.  BTW. you can
use different identities for different projects by setting it
in .git/config, i.e. in per-repository configuration file.


Simple solution, which finds only non-bare repositories, and which
can find false positives:

 $ find ~ -name ".git" -type d -print

More complicated solution, used by gitweb, requires Perl, not checked
that it works correctly, doesn't work with ancient repositories with
symlink HEAD.

 $ perl -e '
 use File::Find qw(find);
 my @list = ();
 find({follow_fast => 1, follow_skip => 2, dangling_symlinks => 0,
       wanted => sub {
         return if (m!^[/.]$!);
         return unless (-d $_);
         push @list, $_ if -e "$_/HEAD" 
       }});
 print join("\n", @list)."\n";
 '

-- 
Jakub Narebski
Poland
