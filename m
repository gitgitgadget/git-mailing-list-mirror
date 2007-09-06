From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Fri, 7 Sep 2007 00:14:30 +0200
Message-ID: <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com>
References: <20070906075104.GA10192@hand.yhbt.net>
	 <1189096669534-git-send-email-hjemli@gmail.com>
	 <20070906210155.GA20938@soma> <20070906213556.GA21234@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:14:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITPcU-0007HW-KO
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 00:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbXIFWOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 18:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753859AbXIFWOc
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 18:14:32 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:41817 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbXIFWOb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 18:14:31 -0400
Received: by nz-out-0506.google.com with SMTP id s18so238023nze
        for <git@vger.kernel.org>; Thu, 06 Sep 2007 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/2Y9qmgBRy9NT3KuUptqVIc4aq6++AJvfmSCxXTjCHI=;
        b=UcmAY1oIeUjtCYEjE2fUMWTMiTR76AuHJlhldvyTtovBiauAnwLEKF5pwNkV2QoLo1MfkGkmOGxh9+GufBUiIZ+V3l37zsgLZWwpP5DRdJb/PsQTsnD0DVwSSGccKu2UjaHrBzaChr98A8ooDQxhA9ZBdEsSuBKntowTzQnbDWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hsognNW6SDX2BopDxcEuuMI9oBxkCd8+df8UXB6FvPQV5HnH+7soSKj7wN7M4s0t0NyD47TiXCKqxVB5iNZgg37Vya5w8UKNDXtX7FrN5wSnH03Lm6XsCCHVL58L5B6mNiO5dwHnVU5HU9yfJHvdfBOKd0Ja6GlEznrRdESBzuk=
Received: by 10.114.107.19 with SMTP id f19mr177572wac.1189116870287;
        Thu, 06 Sep 2007 15:14:30 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Thu, 6 Sep 2007 15:14:30 -0700 (PDT)
In-Reply-To: <20070906213556.GA21234@soma>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57935>

On 9/6/07, Eric Wong <normalperson@yhbt.net> wrote:
> Wait, actually.  --upstream won't ever populate the refs array in
> working_head_info for dcommit

Sorry, I didn't realize that working_head_info() collected commit-ids
later used by dcommit.  But to implement --upstream we could maybe do
something like this:

sub working_head_info {
  my ($head, $refs) = @_;

  if (defined $_upstream) {
    working_head_info_traverse($head, \$refs);
    return working_head_info_traverse($_upstream, undef);
  }

  return working_head_info_traverse($head, \$refs);
}

sub working_head_info_traverse {
  my ($head, $refs) = @_;
  my ($fh, $ctx) = command_output_pipe('log', '--no-color',
'--first-parent', $head);
  ...


(This was written straight into firefox, late at night, by a perl
illiterate. Please be gentle...)

-- 
larsh
