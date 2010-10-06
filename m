From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv5 03/17] gitweb/lib - Very simple file based cache
Date: Wed, 6 Oct 2010 22:57:41 +0000
Message-ID: <AANLkTi=DYHQLftyafoijzagTLmy76Uxsa0fiZ1ZO2wc=@mail.gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
	<1286402526-13143-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 00:57:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3cvo-00045H-K1
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759999Ab0JFW5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 18:57:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35540 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab0JFW5r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 18:57:47 -0400
Received: by iwn5 with SMTP id 5so116240iwn.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f0qVLHyLNoeZDp/cUlt7PTe7OZJNu7x5dhog/Kw2yy0=;
        b=JdwHtgMnNX0TBpMqrGZ18KykeCUesH3Dih/xopIRgEJGK9+GFUhDOLkVLhsvHMUGix
         kXpTj+kag5Sh0bXdO+pn+71bF6M4HGSVF3JKmRUfdTiuiAyB7gLQqmlk5dKgVpWV9b6Z
         o5345f/4+jMcDmVW9oqY0uh7rnvyUlPdi+8Io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cp1F1ZZnO8fc8PUbS29Y4OY9VJ6lFH939HTeh6cHGL1vreR7ObrU0aOAKUOTB62vKN
         MW33lRB0tH2uAsAFIOIpbaoTtQdrsdx4zHb/gAOXaETrkNMlqjbPMM4LHCF9reLUOKO7
         GeY2W2i4+ojoLjPxp8d4LxEujkOK5jdnkP2jc=
Received: by 10.42.196.201 with SMTP id eh9mr1560350icb.122.1286405861315;
 Wed, 06 Oct 2010 15:57:41 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Wed, 6 Oct 2010 15:57:41 -0700 (PDT)
In-Reply-To: <1286402526-13143-4-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158343>

On Wed, Oct 6, 2010 at 22:01, Jakub Narebski <jnareb@gmail.com> wrote:

> +sub new {
> + =C2=A0 =C2=A0 =C2=A0 my ($proto, $p_options_hash_ref) =3D @_;
> +
> + =C2=A0 =C2=A0 =C2=A0 my $class =3D ref($proto) || $proto;
> + =C2=A0 =C2=A0 =C2=A0 my $self =C2=A0=3D {};
> + =C2=A0 =C2=A0 =C2=A0 $self =3D bless($self, $class);

You use:

    my $class =3D ref($proto) || $proto;

Throughout the new class definitions. Presumably that's just
copy/pasted from some old docs and you don't actually want to support:

    my $obj =3D Class->new;
    my $obj2 =3D $obj->new;

It's better just to:

    sub new {
        my ($class, $options) =3D @_:
        my $self =3D bless {}, $class;

Unless there's some reason for the ref($proto) that I've missed.
