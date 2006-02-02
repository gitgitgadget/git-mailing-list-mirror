From: Aneesh Kumar <aneesh.kumar@gmail.com>
Subject: Re: gitview 0.3
Date: Thu, 2 Feb 2006 21:33:53 +0530
Message-ID: <cc723f590602020803u72bdff2ek95fba2ea30970170@mail.gmail.com>
References: <cc723f590602012033w41b49b2ao4423707702086739@mail.gmail.com>
	 <7vzmlauw35.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1827_31539761.1138896233837"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 17:06:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4gwD-00060V-8x
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 17:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWBBQD6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 11:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWBBQD6
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 11:03:58 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:51821 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932093AbWBBQD4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 11:03:56 -0500
Received: by uproxy.gmail.com with SMTP id s2so287643uge
        for <git@vger.kernel.org>; Thu, 02 Feb 2006 08:03:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=f7u0JdSgLUm02BhYYRQ45+G1dajJ2WbSXqhETlnnL/gU1EgggCaAgcEHlcGgbt84k8rjGI0xzrVUiOuDlF+0YHgqcAYQcrZi67hQrRbsVXkxIT1zKhYhYvgVPN45ydZhY78MVFEydnFNaxaLWlg8Qtoxo2uC5wXhS7er6rfB110=
Received: by 10.66.243.20 with SMTP id q20mr357198ugh;
        Thu, 02 Feb 2006 08:03:53 -0800 (PST)
Received: by 10.66.254.16 with HTTP; Thu, 2 Feb 2006 08:03:53 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmlauw35.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15508>

------=_Part_1827_31539761.1138896233837
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 2/2/06, Junio C Hamano <junkio@cox.net> wrote:
> Nice work for 0.low-number version.
>
> On my notebook, I felt really miserable to see that the middle
> band taking so much space to show rev committer timestamp and
> parents.  The bottom window starts with the same information
> repeated (worse, with unreadable timestamp format) and I had to
> scroll all the way down to view the rest of the commit message.

I have rearranged the default with respect these frames. Attaching the
code below. Let me know if it is ok.


>
> If you absolutely want the middle band, maybe instead of showing
> object names in "Parents" "Children" part, you can show the
> one-line commit logs from them there, and pop-up the object
> names along with the rest of commit log message as mouse hovers
> over.
>
> I missed "this commit is branch head of X" and "this commit is
> tagged with T" markers gitk has.
>

I am planning to add this. I am yet to learn fully how to use the
cairo API. gitview was partly my attempt to learn pygtk.


> Needs a bit more compact layout to be useful for me.  In short,
> gitk's display does everything I want it to show in a compact
> enough way and I think there is no reason not to imitate it.
>

One thing i didn't like with gitk was the looks. And the diff window
was so shaded i had to put real effort to read the contents. May be i
didn't had necessary fonts. I don't know


> Do colors of nodes have any significance?  I couldn't tell from
> the UI (and I tried to figure it out without reading code --
> otherwise I cannot tell if the choice of colors is intuitive).
>

One parent of the child follows the same colour. It in a way let one
figure out at what point branch happened and at what point they merged
back.


> It might match more people's expectation if --with-diff were the
> default.
>

This is done. I am attaching the full code below. Can you get the
gitview added git repository so that next time onwards i need to send
only the diff.

> This patch might make merges easier to read.
>
> -- >8 --
> [PATCH] Use "diff-tree -c" to display merges a bit more readably.
>
> --- a/gitview   2006-02-01 21:16:43.000000000 -0800
> +++ b/gitview   2006-02-01 21:46:24.000000000 -0800
> @@ -305,7 +305,7 @@
>                 return message
>
>         def diff_tree(self):
> -               fp =3D os.popen("git diff-tree --pretty -m -v -p " + " " =
+ self.commit_sha1)
> +               fp =3D os.popen("git diff-tree --pretty -c -v -p " + " " =
+ self.commit_sha1)
>                 diff =3D fp.read()
>                 fp.close()
>
>
>
>


I am using the --cc flag and if i don't have any message i get the
commit message only using git cat-file. I guess that is ok

-aneesh

------=_Part_1827_31539761.1138896233837
Content-Type: application/octet-stream; name=gitview
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="gitview"

#! /usr/bin/env python

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

""" gitview
GUI browser for git repository 
This program is based on bzrk by Scott James Remnant <scott@ubuntu.com>
"""
__author__    = "Aneesh Kumar K.V <aneesh.kumar@gmail.com>"


import sys
import os
import gtk
import pygtk
import pango
import re
import time
import gobject
import cairo
import math
import string

try:
    import gtksourceview
    have_gtksourceview = True
except ImportError:
    have_gtksourceview = False
    print "Running without gtksourceview module"


def list_to_string(args, skip):
	count = len(args)
	i = skip
	str_arg=" "
	while (i < count ):
		str_arg = str_arg + args[i]
		str_arg = str_arg + " "
		i = i+1

	return str_arg


class CellRendererGraph(gtk.GenericCellRenderer):
	"""Cell renderer for directed graph.

	This module contains the implementation of a custom GtkCellRenderer that
	draws part of the directed graph based on the lines suggested by the code
	in graph.py.

	Because we're shiny, we use Cairo to do this, and because we're naughty
	we cheat and draw over the bits of the TreeViewColumn that are supposed to
	just be for the background.

	Properties:
	node              (column, colour) tuple to draw revision node,
	in_lines          (start, end, colour) tuple list to draw inward lines,
	out_lines         (start, end, colour) tuple list to draw outward lines.
	"""

	__gproperties__ = {
	"node":         ( gobject.TYPE_PYOBJECT, "node",
			  "revision node instruction",
			  gobject.PARAM_WRITABLE
			),
	"in-lines":     ( gobject.TYPE_PYOBJECT, "in-lines",
			  "instructions to draw lines into the cell",
			  gobject.PARAM_WRITABLE
			),
	"out-lines":    ( gobject.TYPE_PYOBJECT, "out-lines",
			  "instructions to draw lines out of the cell",
			  gobject.PARAM_WRITABLE
			),
	}

	def do_set_property(self, property, value):
		"""Set properties from GObject properties."""
		if property.name == "node":
			self.node = value
		elif property.name == "in-lines":
			self.in_lines = value
		elif property.name == "out-lines":
			self.out_lines = value
		else:
			raise AttributeError, "no such property: '%s'" % property.name

	def box_size(self, widget):
		"""Calculate box size based on widget's font.

		Cache this as it's probably expensive to get.  It ensures that we
		draw the graph at least as large as the text.
		"""
		try:
			return self._box_size
		except AttributeError:
			pango_ctx = widget.get_pango_context()
			font_desc = widget.get_style().font_desc
			metrics = pango_ctx.get_metrics(font_desc)

			ascent = pango.PIXELS(metrics.get_ascent())
			descent = pango.PIXELS(metrics.get_descent())

			self._box_size = ascent + descent + 6
			return self._box_size

	def set_colour(self, ctx, colour, bg, fg):
		"""Set the context source colour.

		Picks a distinct colour based on an internal wheel; the bg
		parameter provides the value that should be assigned to the 'zero'
		colours and the fg parameter provides the multiplier that should be
		applied to the foreground colours.
		"""
		colours = [
		    ( 1.0, 0.0, 0.0 ),
		    ( 1.0, 1.0, 0.0 ),
		    ( 0.0, 1.0, 0.0 ),
		    ( 0.0, 1.0, 1.0 ),
		    ( 0.0, 0.0, 1.0 ),
		    ( 1.0, 0.0, 1.0 ),
		    ]

		colour %= len(colours)
		red   = (colours[colour][0] * fg) or bg
		green = (colours[colour][1] * fg) or bg
		blue  = (colours[colour][2] * fg) or bg

		ctx.set_source_rgb(red, green, blue)

	def on_get_size(self, widget, cell_area):
		"""Return the size we need for this cell.

		Each cell is drawn individually and is only as wide as it needs
		to be, we let the TreeViewColumn take care of making them all
		line up.
		"""
		box_size = self.box_size(widget)

		cols = self.node[0]
		for start, end, colour in self.in_lines + self.out_lines:
			cols = max(cols, start, end)

		width = box_size * (cols + 1)
		height = box_size

		# FIXME I have no idea how to use cell_area properly
		return (0, 0, width, height)

	def on_render(self, window, widget, bg_area, cell_area, exp_area, flags):
		"""Render an individual cell.

		Draws the cell contents using cairo, taking care to clip what we
		do to within the background area so we don't draw over other cells.
		Note that we're a bit naughty there and should really be drawing
		in the cell_area (or even the exposed area), but we explicitly don't
		want any gutter.

		We try and be a little clever, if the line we need to draw is going
		to cross other columns we actually draw it as in the .---' style
		instead of a pure diagonal ... this reduces confusion by an
		incredible amount.
		"""
		ctx = window.cairo_create()
		ctx.rectangle(bg_area.x, bg_area.y, bg_area.width, bg_area.height)
		ctx.clip()

		box_size = self.box_size(widget)

		ctx.set_line_width(box_size / 8)
		ctx.set_line_cap(cairo.LINE_CAP_SQUARE)

		# Draw lines into the cell
		for start, end, colour in self.in_lines:
			ctx.move_to(cell_area.x + box_size * start + box_size / 2,
					bg_area.y - bg_area.height / 2)

			if start - end > 1:
				ctx.line_to(cell_area.x + box_size * start, bg_area.y)
				ctx.line_to(cell_area.x + box_size * end + box_size, bg_area.y)
			elif start - end < -1:
				ctx.line_to(cell_area.x + box_size * start + box_size,
						bg_area.y)
				ctx.line_to(cell_area.x + box_size * end, bg_area.y)

		    	ctx.line_to(cell_area.x + box_size * end + box_size / 2,
					bg_area.y + bg_area.height / 2)

			self.set_colour(ctx, colour, 0.0, 0.65)
			ctx.stroke()

		# Draw lines out of the cell
		for start, end, colour in self.out_lines:
			ctx.move_to(cell_area.x + box_size * start + box_size / 2,
					bg_area.y + bg_area.height / 2)

			if start - end > 1:
				ctx.line_to(cell_area.x + box_size * start,
						bg_area.y + bg_area.height)
				ctx.line_to(cell_area.x + box_size * end + box_size,
						bg_area.y + bg_area.height)
			elif start - end < -1:
				ctx.line_to(cell_area.x + box_size * start + box_size,
						bg_area.y + bg_area.height)
				ctx.line_to(cell_area.x + box_size * end,
						bg_area.y + bg_area.height)

			ctx.line_to(cell_area.x + box_size * end + box_size / 2,
					bg_area.y + bg_area.height / 2 + bg_area.height)

			self.set_colour(ctx, colour, 0.0, 0.65)
			ctx.stroke()

		# Draw the revision node in the right column
		(column, colour) = self.node
		ctx.arc(cell_area.x + box_size * column + box_size / 2,
				cell_area.y + cell_area.height / 2,
				box_size / 4, 0, 2 * math.pi)

		self.set_colour(ctx, colour, 0.0, 0.5)
		ctx.stroke_preserve()

		self.set_colour(ctx, colour, 0.5, 1.0)
		ctx.fill()

class Commit:
	""" This represent a commit object obtained after parsing the git-rev-list 
	output """

	children_sha1 = {}

	def __init__(self, commit_lines):
		self.message 		= ""
		self.author		= ""
		self.date 		= ""
		self.committer 		= ""
		self.commit_date 	= ""
		self.commit_sha1	= ""
		self.parent_sha1	= [ ]
		self.parse_commit(commit_lines)


	def parse_commit(self, commit_lines):

		# First line is the sha1 lines
		line = string.strip(commit_lines[0])
		sha1 = re.split(" ", line)
		self.commit_sha1 = sha1[0]
		self.parent_sha1 = sha1[1:]

		#build the child list
		for parent_id in self.parent_sha1:
			try:
				Commit.children_sha1[parent_id].append(self.commit_sha1)
			except KeyError:
				Commit.children_sha1[parent_id] = [self.commit_sha1]

		# IF we don't have parent
		if (len(self.parent_sha1) == 0):
			self.parent_sha1 = [0]

		for line in commit_lines[1:]:
			m = re.match("^ ", line)
			if (m != None):
				# First line of the commit message used for short log
				if self.message == "":
					self.message = string.strip(line)
				continue

			m = re.match("tree", line)
			if (m != None):
				continue

			m = re.match("parent", line)
			if (m != None):
				continue


			m = re.match("author", line)
			if (m  != None ):
				patch_author = re.split(" ", line)	
				self.author = list_to_string(patch_author[1:-2], 0)
				self.date = time.strftime("%Y-%m-%d %H:%M:%S",
						time.gmtime(float(patch_author[-2])))
				continue

			m = re.match("committer", line)
			if (m  != None ):
				patch_committer = re.split(" ", line)	
				self.committer = list_to_string(patch_committer[1:-2], 0)
				self.commit_date = time.strftime("%Y-%m-%d %H:%M:%S",
						time.gmtime(float(patch_committer[-2])))
				continue

	def get_message(self, with_diff=0):
		if (with_diff == 1):
			message = self.diff_tree()
		else:
			fp = os.popen("git cat-file commit " + self.commit_sha1)
			message = fp.read()
			fp.close()

		return message

	def diff_tree(self):
		fp = os.popen("git diff-tree --pretty --cc  -v -p " + " " + self.commit_sha1)
		diff = fp.read()
		fp.close()
		if (diff == ""):
			# After optimization in case of merge commits if don't
			# have any diffs. Just show the commit message
			diff = self.get_message(0)

		return diff

class DiffWindow:
	"""Diff window.
	This object represents and manages a single window containing the
	differences between two revisions on a branch.
	"""

	def __init__(self):
		self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
		self.window.set_border_width(0)
		self.window.set_title("Git repository browser diff window")

		# Use two thirds of the screen by default
		screen = self.window.get_screen()
		monitor = screen.get_monitor_geometry(0)
		width = int(monitor.width * 0.66)
		height = int(monitor.height * 0.66)
		self.window.set_default_size(width, height)

		self.construct()

	def construct(self):
		"""Construct the window contents."""
		hbox = gtk.HBox(spacing=6)
		hbox.set_border_width(12)
		self.window.add(hbox)
		hbox.show()

		scrollwin = gtk.ScrolledWindow()
		scrollwin.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
		scrollwin.set_shadow_type(gtk.SHADOW_IN)
		hbox.pack_start(scrollwin, expand=True, fill=True)
		scrollwin.show()

		if have_gtksourceview:
			self.buffer = gtksourceview.SourceBuffer()
			slm = gtksourceview.SourceLanguagesManager()
			gsl = slm.get_language_from_mime_type("text/x-patch")
			self.buffer.set_highlight(True)
			self.buffer.set_language(gsl)
			sourceview = gtksourceview.SourceView(self.buffer)
		else:
			self.buffer = gtk.TextBuffer()
			sourceview = gtk.TextView(self.buffer)

		sourceview.set_editable(False)
		sourceview.modify_font(pango.FontDescription("Monospace"))
		scrollwin.add(sourceview)
		sourceview.show()


	def set_diff(self, commit_sha1, parent_sha1):
		"""Set the differences showed by this window.
		Compares the two trees and populates the window with the
		differences.
		"""
		# Diff with the first commit or the last commit shows nothing
		if (commit_sha1 == 0 or parent_sha1 == 0 ):
			return 

		fp = os.popen("git diff-tree -p " + parent_sha1 + " " + commit_sha1)
		self.buffer.set_text(fp.read())
		fp.close()
		self.window.show()


class GitView:
	""" This is the main class
	"""

	def __init__(self, with_diff=0):
		self.with_diff = with_diff
        	self.window =  	gtk.Window(gtk.WINDOW_TOPLEVEL)
        	self.window.set_border_width(0)
		self.window.set_title("Git repository browser")


        	# Use three-quarters of the screen by default
        	screen = self.window.get_screen()
        	monitor = screen.get_monitor_geometry(0)
        	width = int(monitor.width * 0.75)
        	height = int(monitor.height * 0.75)
        	self.window.set_default_size(width, height)

        	# FIXME AndyFitz!
        	icon = self.window.render_icon(gtk.STOCK_INDEX, gtk.ICON_SIZE_BUTTON)
        	self.window.set_icon(icon)

        	self.accel_group = gtk.AccelGroup()
        	self.window.add_accel_group(self.accel_group)

        	self.construct()


	def construct(self):
		"""Construct the window contents."""
		paned = gtk.VPaned()
		paned.pack1(self.construct_top(), resize=False, shrink=True)
		paned.pack2(self.construct_bottom(), resize=False, shrink=True)
		self.window.add(paned)
		paned.show()

	def construct_top(self):
		"""Construct the top-half of the window."""
		vbox = gtk.VBox(spacing=6)
		vbox.set_border_width(12)
		vbox.show()

		scrollwin = gtk.ScrolledWindow()
		scrollwin.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
		scrollwin.set_shadow_type(gtk.SHADOW_IN)
		vbox.pack_start(scrollwin, expand=True, fill=True)
		scrollwin.show()

		self.treeview = gtk.TreeView()
		self.treeview.set_rules_hint(True)
		self.treeview.set_search_column(4)
		self.treeview.connect("cursor-changed", self._treeview_cursor_cb)
		scrollwin.add(self.treeview)
		self.treeview.show()

		cell = CellRendererGraph()
		column = gtk.TreeViewColumn()
		column.set_resizable(False)
		column.pack_start(cell, expand=False)
		column.add_attribute(cell, "node", 1)
		column.add_attribute(cell, "in-lines", 2)
		column.add_attribute(cell, "out-lines", 3)
		self.treeview.append_column(column)

		cell = gtk.CellRendererText()
		cell.set_property("width-chars", 65)
		cell.set_property("ellipsize", pango.ELLIPSIZE_END)
		column = gtk.TreeViewColumn("Message")
		column.set_resizable(True)
		column.pack_start(cell, expand=True)
		column.add_attribute(cell, "text", 4)
		self.treeview.append_column(column)

		cell = gtk.CellRendererText()
		cell.set_property("width-chars", 40)
		cell.set_property("ellipsize", pango.ELLIPSIZE_END)
		column = gtk.TreeViewColumn("Author")
		column.set_resizable(True)
		column.pack_start(cell, expand=True)
		column.add_attribute(cell, "text", 5)
		self.treeview.append_column(column)

		cell = gtk.CellRendererText()
		cell.set_property("ellipsize", pango.ELLIPSIZE_END)
		column = gtk.TreeViewColumn("Date")
		column.set_resizable(True)
		column.pack_start(cell, expand=True)
		column.add_attribute(cell, "text", 6)
		self.treeview.append_column(column)

		return vbox


	def construct_bottom(self):
		"""Construct the bottom half of the window."""
		vbox = gtk.VBox(False, spacing=6)
		vbox.set_border_width(12)
		(width, height) = self.window.get_size()
		vbox.set_size_request(width, int(height / 2.5))
		vbox.show()

		self.table = gtk.Table(rows=4, columns=4)
		self.table.set_row_spacings(6)
		self.table.set_col_spacings(6)
		vbox.pack_start(self.table, expand=False, fill=True)
		self.table.show()

		align = gtk.Alignment(0.0, 0.5)
		label = gtk.Label()
		label.set_markup("<b>Revision:</b>")
		align.add(label)
		self.table.attach(align, 0, 1, 0, 1, gtk.FILL, gtk.FILL)
		label.show()
		align.show()

		align = gtk.Alignment(0.0, 0.5)
		self.revid_label = gtk.Label()
		self.revid_label.set_selectable(True)
		align.add(self.revid_label)
		self.table.attach(align, 1, 2, 0, 1, gtk.EXPAND | gtk.FILL, gtk.FILL)
		self.revid_label.show()
		align.show()

		align = gtk.Alignment(0.0, 0.5)
		label = gtk.Label()
		label.set_markup("<b>Committer:</b>")
		align.add(label)
		self.table.attach(align, 0, 1, 1, 2, gtk.FILL, gtk.FILL)
		label.show()
		align.show()

		align = gtk.Alignment(0.0, 0.5)
		self.committer_label = gtk.Label()
		self.committer_label.set_selectable(True)
		align.add(self.committer_label)
		self.table.attach(align, 1, 2, 1, 2, gtk.EXPAND | gtk.FILL, gtk.FILL)
		self.committer_label.show()
		align.show()

		align = gtk.Alignment(0.0, 0.5)
		label = gtk.Label()
		label.set_markup("<b>Timestamp:</b>")
		align.add(label)
		self.table.attach(align, 0, 1, 2, 3, gtk.FILL, gtk.FILL)
		label.show()
		align.show()

		align = gtk.Alignment(0.0, 0.5)
		self.timestamp_label = gtk.Label()
		self.timestamp_label.set_selectable(True)
		align.add(self.timestamp_label)
		self.table.attach(align, 1, 2, 2, 3, gtk.EXPAND | gtk.FILL, gtk.FILL)
		self.timestamp_label.show()
		align.show()

		align = gtk.Alignment(0.0, 0.5)
		label = gtk.Label()
		label.set_markup("<b>Parents:</b>")
		align.add(label)
		self.table.attach(align, 0, 1, 3, 4, gtk.FILL, gtk.FILL)
		label.show()
		align.show()
		self.parents_widgets = []

		align = gtk.Alignment(0.0, 0.5)
		label = gtk.Label()
		label.set_markup("<b>Children:</b>")
		align.add(label)
		self.table.attach(align, 2, 3, 3, 4, gtk.FILL, gtk.FILL)
		label.show()
		align.show()
		self.children_widgets = []

		scrollwin = gtk.ScrolledWindow()
		scrollwin.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
		scrollwin.set_shadow_type(gtk.SHADOW_IN)
		vbox.pack_start(scrollwin, expand=True, fill=True)
		scrollwin.show()

		if have_gtksourceview:
			self.message_buffer = gtksourceview.SourceBuffer()
			slm = gtksourceview.SourceLanguagesManager()
			gsl = slm.get_language_from_mime_type("text/x-patch")
			self.message_buffer.set_highlight(True)
			self.message_buffer.set_language(gsl)
			sourceview = gtksourceview.SourceView(self.message_buffer)
		else:
			self.message_buffer = gtk.TextBuffer()
			sourceview = gtk.TextView(self.message_buffer)

		sourceview.set_editable(False)
		sourceview.modify_font(pango.FontDescription("Monospace"))
		scrollwin.add(sourceview)
		sourceview.show()

		return vbox

	def _treeview_cursor_cb(self, *args):
		"""Callback for when the treeview cursor changes."""
		(path, col) = self.treeview.get_cursor()
		commit = self.model[path][0]

		if commit.committer is not None:
			committer = commit.committer
			timestamp = commit.commit_date
			message   =  commit.get_message(self.with_diff)
			revid_label = commit.commit_sha1
		else:
    			committer = ""
    			timestamp = ""
    			message = ""
			revid_label = ""

		self.revid_label.set_text(revid_label)
		self.committer_label.set_text(committer)
		self.timestamp_label.set_text(timestamp)
		self.message_buffer.set_text(message)

		for widget in self.parents_widgets:
			self.table.remove(widget)

		self.parents_widgets = []
		self.table.resize(4 + len(commit.parent_sha1) - 1, 4)
		for idx, parent_id in enumerate(commit.parent_sha1):
			self.table.set_row_spacing(idx + 3, 0)

			align = gtk.Alignment(0.0, 0.0)
			self.parents_widgets.append(align)
			self.table.attach(align, 1, 2, idx + 3, idx + 4,
					gtk.EXPAND | gtk.FILL, gtk.FILL)
			align.show()

			hbox = gtk.HBox(False, 0)
			align.add(hbox)
			hbox.show()

			label = gtk.Label(parent_id)
			label.set_selectable(True)
			hbox.pack_start(label, expand=False, fill=True)
			label.show()

			image = gtk.Image()
			image.set_from_stock(gtk.STOCK_JUMP_TO, gtk.ICON_SIZE_MENU)
			image.show()

			button = gtk.Button()
			button.add(image)
			button.set_relief(gtk.RELIEF_NONE)
			button.connect("clicked", self._go_clicked_cb, parent_id)
			hbox.pack_start(button, expand=False, fill=True)
			button.show()

			image = gtk.Image()
			image.set_from_stock(gtk.STOCK_FIND, gtk.ICON_SIZE_MENU)
			image.show()

			button = gtk.Button()
			button.add(image)
			button.set_relief(gtk.RELIEF_NONE)
			button.set_sensitive(True)
			button.connect("clicked", self._show_clicked_cb,
					commit.commit_sha1, parent_id)
			hbox.pack_start(button, expand=False, fill=True)
			button.show()

		# Populate with child details
		for widget in self.children_widgets:
			self.table.remove(widget)

		self.children_widgets = []
		try:
			child_sha1 = Commit.children_sha1[commit.commit_sha1]
		except KeyError:
			# We don't have child
			child_sha1 = [ 0 ]

		if ( len(child_sha1) > len(commit.parent_sha1)):
			self.table.resize(4 + len(child_sha1) - 1, 4)

		for idx, child_id in enumerate(child_sha1):
			self.table.set_row_spacing(idx + 3, 0)

			align = gtk.Alignment(0.0, 0.0)
			self.children_widgets.append(align)
			self.table.attach(align, 3, 4, idx + 3, idx + 4,
					gtk.EXPAND | gtk.FILL, gtk.FILL)
			align.show()

			hbox = gtk.HBox(False, 0)
			align.add(hbox)
			hbox.show()

			label = gtk.Label(child_id)
			label.set_selectable(True)
			hbox.pack_start(label, expand=False, fill=True)
			label.show()

			image = gtk.Image()
			image.set_from_stock(gtk.STOCK_JUMP_TO, gtk.ICON_SIZE_MENU)
			image.show()

			button = gtk.Button()
			button.add(image)
			button.set_relief(gtk.RELIEF_NONE)
			button.connect("clicked", self._go_clicked_cb, child_id)
			hbox.pack_start(button, expand=False, fill=True)
			button.show()

			image = gtk.Image()
			image.set_from_stock(gtk.STOCK_FIND, gtk.ICON_SIZE_MENU)
			image.show()

			button = gtk.Button()
			button.add(image)
			button.set_relief(gtk.RELIEF_NONE)
			button.set_sensitive(True)
			button.connect("clicked", self._show_clicked_cb,
					child_id, commit.commit_sha1)
			hbox.pack_start(button, expand=False, fill=True)
			button.show()

	def _destroy_cb(self, widget):
		"""Callback for when a window we manage is destroyed."""
		self.quit()


	def quit(self):
		"""Stop the GTK+ main loop."""
		gtk.main_quit()

	def run(self, args):
		self.set_branch(args)
        	self.window.connect("destroy", self._destroy_cb)
		self.window.show()
		gtk.main()

	def set_branch(self, args):
		"""Fill in different windows with info from the reposiroty"""
		fp = os.popen("git rev-parse --sq --default HEAD " + list_to_string(args, 1))
		git_rev_list_cmd = fp.read()
		fp.close()
		fp = os.popen("git rev-list  --header --topo-order --parents " + git_rev_list_cmd)
		self.update_window(fp)

	def update_window(self, fp):
		commit_lines = []

		self.model = gtk.ListStore(gobject.TYPE_PYOBJECT, gobject.TYPE_PYOBJECT,
				gobject.TYPE_PYOBJECT, gobject.TYPE_PYOBJECT, str, str, str)

		# used for cursor positioning 
		self.index = {}

		self.colours = {}
		self.nodepos = {}
		self.incomplete_line = {}

		index = 0
		last_colour = 0
		last_nodepos = -1
		out_line = []	
		input_line = fp.readline()
		while (input_line != ""):
			# The commit header ends with '\0'
			# This NULL is immediately followed by the sha1 of the 
			# next commit
			if (input_line[0] != '\0'):
				commit_lines.append(input_line)
				input_line = fp.readline()
				continue;

			commit = Commit(commit_lines)
			if (commit != None ):
				(out_line, last_colour, last_nodepos) = self.draw_graph(commit,
										index, out_line,
										last_colour,
										last_nodepos)
				self.index[commit.commit_sha1] = index
				index += 1

			# Skip the '\0
			commit_lines = []
			commit_lines.append(input_line[1:])
			input_line = fp.readline()

		fp.close()

		self.treeview.set_model(self.model)
		self.treeview.show()

	def draw_graph(self, commit, index, out_line, last_colour, last_nodepos):
		in_line=[]

		#   |   -> outline
		#   X
		#   |\  <- inline 

		# Reset nodepostion
		if (last_nodepos > 5):
			last_nodepos = 0

		# Add the incomplete lines of the last cell in this 
		for sha1 in self.incomplete_line.keys():
			if ( sha1 != commit.commit_sha1):
				for pos in self.incomplete_line[sha1]:
					in_line.append((pos, pos, self.colours[sha1]))
			else:
				del self.incomplete_line[sha1]

		try:
			colour = self.colours[commit.commit_sha1]
		except KeyError:
			last_colour +=1
			self.colours[commit.commit_sha1] = last_colour
			colour =  last_colour
		try:
			node_pos = self.nodepos[commit.commit_sha1]
		except KeyError:
			last_nodepos +=1
			self.nodepos[commit.commit_sha1] = last_nodepos
			node_pos = last_nodepos

		#The first parent always continue on the same line
		try:
			# check we alreay have the value
			tmp_node_pos = self.nodepos[commit.parent_sha1[0]]
		except KeyError:
			self.colours[commit.parent_sha1[0]] = colour
			self.nodepos[commit.parent_sha1[0]] = node_pos

		in_line.append((node_pos, self.nodepos[commit.parent_sha1[0]],
					self.colours[commit.parent_sha1[0]]))

		self.add_incomplete_line(commit.parent_sha1[0], index+1)

		if (len(commit.parent_sha1) > 1):
			for parent_id in commit.parent_sha1[1:]:
				try:
					tmp_node_pos = self.nodepos[parent_id]
				except KeyError:
					last_colour += 1;
					self.colours[parent_id] = last_colour
					last_nodepos +=1
					self.nodepos[parent_id] = last_nodepos

				in_line.append((node_pos, self.nodepos[parent_id],
							self.colours[parent_id]))
				self.add_incomplete_line(parent_id, index+1)

		node = (node_pos, colour) 

		self.model.append([commit, node, out_line, in_line,
				commit.message, commit.author, commit.date]) 

		return (in_line, last_colour, last_nodepos)

	def add_incomplete_line(self, sha1, index):
		try:
			self.incomplete_line[sha1].append(self.nodepos[sha1])
		except KeyError:
			self.incomplete_line[sha1] = [self.nodepos[sha1]]


	def _go_clicked_cb(self, widget, revid):
		"""Callback for when the go button for a parent is clicked."""
		try:
			self.treeview.set_cursor(self.index[revid])
		except KeyError:
			print "Revision %s not present in the list" % revid
			# revid == 0 is the parent of the first commit
			if (revid != 0 ):
				print "Try running gitview without any options"

		self.treeview.grab_focus()

	def _show_clicked_cb(self, widget,  commit_sha1, parent_sha1):
		"""Callback for when the show button for a parent is clicked."""
		window = DiffWindow()
		window.set_diff(commit_sha1, parent_sha1)
		self.treeview.grab_focus()

if __name__ == "__main__":
	without_diff = 0

	if (len(sys.argv) > 1 ):
		if (sys.argv[1] == "--without-diff"):
			without_diff = 1

	view = GitView( without_diff != 1)
	view.run(sys.argv[without_diff:])



------=_Part_1827_31539761.1138896233837--
