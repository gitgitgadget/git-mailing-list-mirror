From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCHv2 09/10] gitweb/cache.pm - Regenerate (refresh) cache in background
Date: Tue, 9 Feb 2010 23:23:17 +0100
Message-ID: <201002092323.24832.jnareb@gmail.com>
References: <1265711427-15193-1-git-send-email-jnareb@gmail.com> <1265711427-15193-10-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 09 23:23:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeyUk-0003yY-2F
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 23:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab0BIWXk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 17:23:40 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:50513 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab0BIWXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 17:23:40 -0500
Received: by bwz23 with SMTP id 23so729581bwz.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 14:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=o2bXbnSbyl/TUvRx4PsZ1rApZhI2jL35XGDNvMbYCMg=;
        b=fOl3d+KQdnS6cFEz1zU9NK3JB68hOE4x9y0vkr82pAsbeIUajKSmYZEPunGNVBH95F
         tC+yDUtRlJzdGGBqCwsF9Jo/g8PJ4IEaUnlNataTqKHAVTKRexaGVRrxLUNYui2HHHj0
         2YzrPiDfRNLseEP6jv9HlCTI0UJRVIppCEc0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eqndlCTIbj8Qyrn1QAVTMHHWIUuyWH+MVeGu5jvo7zHnFGo3tFVSakXb8V3Or47Ard
         jGsD+rf6tJN6g8zMX70sw+HRdiRp/eDlwQ50Qfta4dmA+eV3AbppS4VQ5keMK14kb+AN
         EO/fONOQYSYsS3EvpomlAvszFIXRmhcqvSpTE=
Received: by 10.204.36.71 with SMTP id s7mr4331231bkd.171.1265754218237;
        Tue, 09 Feb 2010 14:23:38 -0800 (PST)
Received: from ?192.168.1.13? (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id 15sm276831bwz.0.2010.02.09.14.23.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 14:23:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1265711427-15193-10-git-send-email-jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139449>

On Tue, 9 Feb 2010, Jakub Narebski wrote:

[...]
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0my $pid =3D fork() if (=
$data && $self->get_background_cache());
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!defined $pid || $p=
id) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
# parent, or didn't fork
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
$data =3D $p_coderef->($self, $p_key);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
$self->set($p_key, $data);
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
if ($pid) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0# releases lock before waiting and exiting
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0close $lock_fh;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0# wait for child (which would print) and exit
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0waitpid $pid, 0;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0exit 0;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
}
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
# child is to serve stale data
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
return $data;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
[...]

I have decide to rely on $SIG{CHLD} =3D 'IGNORE' to not generate zombie=
s,
and consistently exit in child (in forked process) and return in parent=
=2E
This change would be in next version of this series.

--=20
Jakub Narebski
Poland
